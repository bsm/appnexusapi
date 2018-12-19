class AppnexusApi::TinyTagService < AppnexusApi::Service
  def initialize(connection, member_id, **opts)
    super(connection, name: 'tinytag', uri_suffix: "tt/#{member_id}", **opts)
  end
end
