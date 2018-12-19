module AppnexusApi
  class ReadOnlyService < Service
    def initialize(connection, **opts)
      super(connection, read_only: true, **opts)
    end
  end
end
