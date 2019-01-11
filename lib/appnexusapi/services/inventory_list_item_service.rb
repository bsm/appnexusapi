class AppnexusApi::InventoryListItemService < AppnexusApi::Service
  def initialize(conn, inventory_list_id, **opts)
    super(conn, uri_suffix: "inventory-list/#{inventory_list_id}/item", **opts)
  end
end
