require 'spec_helper'

describe AppnexusApi::SiteService do
  include_context 'with a publisher'

  let(:code) { 'spec_pub_code' }
  let(:site_service) { described_class.new(connection) }
  let(:site_code) { 'spec_site_code' }

  it "site life cycle" do
    VCR.use_cassette('site_lifecycle') do
      new_site_url_params = { publisher_id: publisher.id }
      new_site_params = {
        name: "Site Name",
        code: site_code,
        url: "http://www.example.com",
        intended_audience: "general",
        audited: true
      }

      new_site = site_service.create(new_site_url_params, new_site_params)
      expect(new_site.name).to eq("Site Name")
      expect(new_site.code).to eq(site_code)
      expect(new_site.url).to  eq("http://www.example.com")
      expect(new_site.intended_audience).to eq("general")
      expect(new_site.audited).to eq(true)

      new_site.delete
      publisher.delete
    end
  end
end
