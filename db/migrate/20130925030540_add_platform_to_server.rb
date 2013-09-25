class AddPlatformToServer < ActiveRecord::Migration
  def change
    add_column :plesk_kit_servers, :platform, :string
  end
end
