require 'spec_helper'

describe AppnexusApi::InventoryListService do
  subject { described_class.new(connection) }

  its(:name) { is_expected.to eq('inventory_list') }
  its(:plural_name) { is_expected.to eq('inventory_lists') }
  its(:uri_name) { is_expected.to eq('inventory-list') }
  its(:plural_uri_name) { is_expected.to eq('inventory-lists') }
  its(:uri_suffix) { is_expected.to eq('inventory-list') }

  it 'supports get operation' do
    VCR.use_cassette('inventory_list_service_get') do
      resp = subject.get('start_element' => 0, 'num_elements' => 1)
      expect(resp.size).to eq(1)
      expect(resp.first.to_h).to include("id" => 3901, "name" => "XYZ Whitelist")
    end
  end
end
