class AddPlatformToResellerAccount < ActiveRecord::Migration
  def change
    add_column :plesk_kit_reseller_accounts, :platform, :string
  end
end
