class AppnexusApi::BidderInstanceService < AppnexusApi::Service
  def initialize(connection, bidder_id, **opts)
    super(connection, name: 'instance', uri_suffix: "bidder-instance/#{bidder_id}", **opts)
  end

  def delete(id)
    raise AppnexusApi::NotImplemented, "To remove an instance, please set it to inactive."
  end
end
