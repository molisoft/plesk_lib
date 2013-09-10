# This migration comes from plesk_kit (originally 20130906033658)
class CreatePleskKitCustomerAccounts < ActiveRecord::Migration
  def change
    create_table :plesk_kit_customer_accounts do |t|
      t.string :cname
      t.string :pname
      t.string :login
      t.string :passwd

      t.timestamps
    end
  end
end
