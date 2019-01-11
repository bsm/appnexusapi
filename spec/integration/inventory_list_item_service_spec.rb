require 'spec_helper'

describe AppnexusApi::InventoryListItemService do
  subject { described_class.new(connection, 33) }

  its(:name) { is_expected.to eq('inventory_list_item') }
  its(:plural_name) { is_expected.to eq('inventory_list_items') }
  its(:uri_name) { is_expected.to eq('inventory-list-item') }
  its(:plural_uri_name) { is_expected.to eq('inventory-list-items') }
  its(:uri_suffix) { is_expected.to eq('inventory-list/33/item') }

  it 'supports get operation' do
    VCR.use_cassette('inventory_list_item_service_get') do
      resp = subject.get('start_element' => 0, 'num_elements' => 1)
      expect(resp.size).to eq(1)
      expect(resp.first.to_h).to include("id" => 1, "inventory_url" => "bad-domain.com")
    end
  end
end
