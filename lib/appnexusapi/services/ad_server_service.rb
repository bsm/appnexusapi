class AppnexusApi::AdServerService < AppnexusApi::ReadOnlyService
  def initialize(connection, **opts)
    super(connection, name: 'adserver', uri_suffix: 'ad-server', **opts)
  end
end
