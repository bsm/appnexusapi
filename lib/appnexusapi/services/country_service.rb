class AppnexusApi::CountryService < AppnexusApi::Service
  def initialize(conn, **opts)
    super(conn, plural_name: 'countries', **opts)
  end
end
