# This migration comes from plesk_kit (originally 20130925025125)
class AddPlatformToCustomerAccount < ActiveRecord::Migration
  def change
    add_column :plesk_kit_customer_accounts, :platform, :string
  end
end
