module PleskKit
  class Server < ActiveRecord::Base
    attr_accessible :environment, :ghostname, :host, :password, :username

    has_many :customer_accounts
    has_many :reseller_accounts

    validates :environment, :host, :username, :password, :presence => {:message => 'Cannot be blank! Requires, at minimum, environment (dev,staging,production), host without a port, username, and password'}


    def self.most_suitable_for_new_customer
      servers = 'collect_ram_info_for_servers'
      servers = 'sort_by_available_ram_descending(servers)'
      until servers.blank?
        if servers.first.starved_of_resources?
          'remove from array of servers'
          'throw error'
        else
          return s
        end
      end
    end

    def starved_of_resources?
      # TODO Check CPU, Diskspace, RAM. Return false if all met satisfactorily.
      false
    end

  end
end
