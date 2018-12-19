class AppnexusApi::ContentCategoryService < AppnexusApi::Service
  def initialize(connection, **opts)
    super(connection, plural_name: 'content_categories', **opts)
  end
end
