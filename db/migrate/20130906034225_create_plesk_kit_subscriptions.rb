class CreatePleskKitSubscriptions < ActiveRecord::Migration
  def change
    create_table :plesk_kit_subscriptions do |t|
      t.string :name
      t.string :owner_id
      t.string :owner_login
      t.string :ip_address
      t.string :plan_name
      t.integer :service_plan_id
      t.integer :customer_account_id
      t.integer :reseller_account_id

      t.timestamps
    end
  end
end
