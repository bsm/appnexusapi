require 'spec_helper'

describe AppnexusApi::InsertionOrderService do
  subject { described_class.new(connection) }

  its(:name) { is_expected.to eq('insertion_order') }
  its(:plural_name) { is_expected.to eq('insertion_orders') }
  its(:uri_name) { is_expected.to eq('insertion-order') }
  its(:plural_uri_name) { is_expected.to eq('insertion-orders') }
  its(:uri_suffix) { is_expected.to eq('insertion-order') }

  it 'supports get operation' do
    VCR.use_cassette('insertion_order_service_get') do
      resp = subject.get('start_element' => 0, 'num_elements' => 1)
      expect(resp.size).to eq(1)
      expect(resp.first.to_h).to include("id" => 1201, "name" => "MyIO")
    end
  end
end
