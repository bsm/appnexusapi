class AppnexusApi::CreativeTemplateService < AppnexusApi::Service
  def initialize(connection, **opts)
    super(connection, name: 'template',  uri_suffix: 'template', **opts)
  end

  def delete(id)
    raise AppnexusApi::NotImplemented
  end
end
