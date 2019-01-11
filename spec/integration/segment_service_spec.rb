require 'spec_helper'

describe AppnexusApi::SegmentService do
  subject { described_class.new(connection) }

  its(:name) { is_expected.to eq('segment') }
  its(:plural_name) { is_expected.to eq('segments') }
  its(:uri_name) { is_expected.to eq('segment') }
  its(:plural_uri_name) { is_expected.to eq('segments') }
  its(:uri_suffix) { is_expected.to eq('segment') }

  it 'supports get operation' do
    VCR.use_cassette('segment_service_get') do
      resp = subject.get()
      expect(resp.size).to eq(1)
      expect(resp.first.to_h).to include("id" => 11836, "short_name" => "March 10")
    end
  end
end
