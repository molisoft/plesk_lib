module PleskKit
  class Communicator

    require 'net/http'
    require 'builder'
    require "rexml/document"

    # The shell for the XML
    def self.shell
      Builder::XmlMarkup.new
    end

    def self.pack_and_play_with_customer_or_reseller account
      server = PleskKit::Server.where(:environment => Rails.env.to_s, :platform => account.platform).first
      packet = account.pack_this shell
      response = transportation_for packet,server
      account.analyse response[0], server.id
    end

    def self.pack_and_play_with_subscription subscription, customer_account
      server = customer_account.server
      packet = subscription.pack_this shell, customer_account
      response = transportation_for packet,server
      subscription.analyse response[0],customer_account
    end

    def self.sync_subscription sub, sub_guid
      server = PleskKit::Server.first
      packet = sub.sync_pack shell,sub_guid
      response = transportation_for packet,server
      sub.analyse response[0]
    end

    def self.get_service_plan service_plan, server
      server = PleskKit::Server.first
      packet = service_plan.build_xml_for_get shell
      response = transportation_for packet, server
      service_plan.analyse response[0], server
    end

    def self.push_service_plan service_plan, server
      server = PleskKit::Server.first
      packet = service_plan.build_xml_for_add shell
      response = transportation_for packet, server
      service_plan.analyse response[0], server
    end

    # Sends packet to plesk
    def self.transportation_for packet, server
      c = PleskKit::Client.new(server)
      c.send_to_plesk packet
    end

  end
end