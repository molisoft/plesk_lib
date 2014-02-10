class AddIpAddressToPleskKitServers < ActiveRecord::Migration
  def change
    add_column :plesk_kit_servers, :ip_address, :string
  end
end
