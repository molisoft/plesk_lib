class CreatePleskKitResellerAccounts < ActiveRecord::Migration
  def change
    create_table :plesk_kit_reseller_accounts do |t|
      t.string :cname
      t.string :pname
      t.string :login
      t.string :passwd
      t.string :plan_name
      t.integer :service_plan_id
      t.integer :server_id

      t.timestamps
    end
  end
end
