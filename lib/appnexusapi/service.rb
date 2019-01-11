class AppnexusApi::Service
  DEFAULT_NUMBER_OF_ELEMENTS = 100

  attr_reader :name, :plural_name, :uri_name, :plural_uri_name, :uri_suffix

  def initialize(connection, read_only: false, name: nil, plural_name: nil, uri_name: nil, plural_uri_name: nil, uri_suffix: nil)
    @connection = connection
    @name = name || begin
      str = self.class.name.split('::').last.sub(/Service\z/, '')
      str.gsub(/(.)([A-Z])/, '\1_\2').downcase
    end
    @plural_name = plural_name || "#{@name}s"
    @uri_name = uri_name || @name.gsub('_', '-')
    @plural_uri_name = plural_uri_name || @plural_name.gsub('_', '-')
    @uri_suffix = uri_suffix || @uri_name
    @read_only = read_only
  end

  def get(params = {})
    params = { 'num_elements' => DEFAULT_NUMBER_OF_ELEMENTS, 'start_element' => 0 }.merge(params)
    parse_response(@connection.get(uri_suffix, params).body['response'])
  end

  # Page through all available elements automatically
  def get_all(params = {})
    responses = []
    last_responses = get(params)

    while last_responses.size > 0
      responses += last_responses
      last_responses = get(params.merge('start_element' => responses.size))
    end

    responses
  end

  # All returns an enumerator.
  def all(params = {})
    Enumerator.new do |enum|
      limit  = params.fetch('num_elements', DEFAULT_NUMBER_OF_ELEMENTS).to_i
      offset = params.fetch('start_element', 0).to_i

      begin
        responses = get(params.merge('start_element' => offset))
        responses.each {|res| enum << res }
        offset += responses.size
      end until responses.size != limit
    end
  end

  def create(route_params = {}, body = {})
    check_read_only!
    route = @connection.build_url(uri_suffix, route_params)
    response = @connection.post(route, { uri_name => body }).body['response']
    validate_response!(response)

    parse_response(response).first
  end

  def update(id, route_params = {}, body = {})
    check_read_only!
    route = @connection.build_url(uri_suffix, route_params.merge('id' => id))
    response = @connection.put(route, { uri_name => body }).body['response']
    validate_response!(response)

    parse_response(response).first
  end

  def delete(id, route_params)
    check_read_only!
    route = @connection.build_url(uri_suffix, route_params.merge('id' => id))
    response = @connection.delete(route).body['response']
    validate_response!(response)

    response
  end

  private

  def check_read_only!
    raise(AppnexusApi::NotImplemented, "Service is read-only.") if @read_only
  end

  def validate_response!(response)
    return unless response['error_id']

    response.delete('dbg')
    raise AppnexusApi::BadRequest.new(response.inspect)
  end

  def parse_response(response)
    case key = resource_name(response)
    when plural_name, plural_uri_name
      response[key].map { |json| AppnexusApi::Resource.new(json, self, response['dbg']) }
    when name, uri_name
      [AppnexusApi::Resource.new(response[key], self, response['dbg'])]
    end
  end

  def resource_name(response)
    [plural_name, plural_uri_name, name, uri_name].detect { |n| response.key?(n) }
  end
end
