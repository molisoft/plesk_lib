# This migration comes from plesk_kit (originally 20130906040817)
class CreatePleskKitServers < ActiveRecord::Migration
  def change
    create_table :plesk_kit_servers do |t|
      t.string :environment
      t.string :host
      t.string :username
      t.string :password
      t.string :ghostname

      t.timestamps
    end
  end
end
