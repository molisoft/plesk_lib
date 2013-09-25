# This migration comes from plesk_kit (originally 20130925025132)
class AddPlatformToResellerAccount < ActiveRecord::Migration
  def change
    add_column :plesk_kit_reseller_accounts, :platform, :string
  end
end
