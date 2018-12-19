class AppnexusApi::SegmentService < AppnexusApi::Service
  def initialize(connection, member_id, **opts)
    super(connection, uri_suffix: "segments/#{member_id}", **opts)
  end
end
