module PleskKit
  class Server < ActiveRecord::Base
    attr_accessible :environment, :ghostname, :host, :password, :username, :platform

    has_many :customer_accounts
    has_many :reseller_accounts

    validates :environment, :host, :username, :password, :presence => {:message => 'Cannot be blank! Requires, at minimum, environment (dev,staging,production), host without a port, username, and password'}


    def self.most_suitable_for_new_customer(platform)
      server_list = PleskKit::Server.where(:environment => Rails.env.to_s, :platform => platform)
      servers = []
      server_list.each { |s| servers << PleskKit::Communicator.get_server_stats(server=s) }
      servers = servers.sort_by { |hsh| hsh[:ram] }.reverse
      PleskKit::Server.find servers.first[:id]
    end

    def starved_of_resources?
      # TODO Check CPU, Diskspace, RAM. Return false if all met satisfactorily.
      false
    end

    def pack_this shell
      xml = shell
      xml.instruct!
      xml.packet(:version => '1.6.3.5') {
        xml.server{
          xml.get{
            xml.stat()
          }
        }
      }
      return xml.target!
    end

    def analyse_this response
      xml = REXML::Document.new(response)
      free_ram = cpu = nil
      ram = xml.root.elements['//mem']
      ram.each do |r|
        if r.name == 'free'
          free_ram = r.text
        end
      end
      cpu = xml.root.elements['//l15'].text
      return {id:self.id,ram:free_ram,cpu:cpu}
    end


  end
end
