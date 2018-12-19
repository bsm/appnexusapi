class AppnexusApi::CategoryService < AppnexusApi::ReadOnlyService
  def initialize(connection, **opts)
    super(connection, plural_name: 'categories', **opts)
  end
end
