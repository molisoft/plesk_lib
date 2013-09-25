# This migration comes from plesk_kit (originally 20130925030540)
class AddPlatformToServer < ActiveRecord::Migration
  def change
    add_column :plesk_kit_servers, :platform, :string
  end
end
