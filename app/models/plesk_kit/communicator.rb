module PleskKit
  class Communicator

    require 'net/http'
    require 'builder'
    require "rexml/document"

    # The shell for the XML
    def self.shell
      Builder::XmlMarkup.new
    end

    #  Creates object and sends it in one go
      # Code only written for Customer::Account so far
    def self.pack_and_play_with s, customer_account = nil
      server = PleskKit::Server.find_by_environment(Rails.env.to_s)
      #TODO server = PleskKit::Server.most_suitable_for_new_customer
      packet = nil
      if customer_account.blank?
        packet = s.pack_this shell
      else
        packet = s.pack_this shell, customer_account
      end
      response = transportation_for packet,server
      if (s.class.to_s == 'PleskKit::CustomerAccount' || s.class.to_s ==  'PleskKit::ResellerAccount')
        s.analyse response[0], server.id
      else
        customer_account.blank? ? (s.analyse response[0]) : (s.analyse response[0],customer_account)
      end
    end

    # Sends packet to plesk
    def self.transportation_for packet, server
      c = PleskKit::Client.new(server)
      c.send_to_plesk packet
    end

    def self.sync_subscription sub, sub_guid
      server = PleskKit::Server.first
      packet = sub.sync_pack shell,sub_guid
      response = transportation_for packet,server
      sub.analyse response[0]
    end
  end
end