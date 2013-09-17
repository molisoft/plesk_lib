# This migration comes from plesk_kit (originally 20130917012645)
class CreatePleskKitServicePlans < ActiveRecord::Migration
  def change
    create_table :plesk_kit_service_plans do |t|
      t.string :name
      t.string :domains
      t.string :traffic
      t.string :mailboxes
      t.string :storage

      t.timestamps
    end
  end
end
