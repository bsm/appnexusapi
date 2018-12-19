class AppnexusApi::OperatingSystemExtendedService < AppnexusApi::ReadOnlyService
  def initialize(connection, **opts)
    super(connection, plural_name: 'operating-systems-extended', **opts)
  end
end
