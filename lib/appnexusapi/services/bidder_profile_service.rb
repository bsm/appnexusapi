class AppnexusApi::BidderProfileService < AppnexusApi::Service
  def initialize(connection, bidder_id, **opts)
    super(connection, name: 'profile', uri_suffix: "profile/#{bidder_id}", **opts)
  end

  def delete(id)
    raise AppnexusApi::NotImplemented
  end
end
