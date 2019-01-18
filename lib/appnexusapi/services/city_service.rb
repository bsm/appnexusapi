class AppnexusApi::CityService < AppnexusApi::Service
  def initialize(conn, **opts)
    super(conn, plural_name: 'cities', **opts)
  end
end