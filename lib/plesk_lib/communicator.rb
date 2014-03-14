module PleskLib
  class Communicator

    require 'net/http'
    require 'builder'
    require "rexml/document"

    # The shell for the XML
    def self.shell

    end

    def self.pack_and_play_with_account account
      server = PleskLib::Server.most_suitable_for_new_customer(account.platform)

    end

    def self.pack_and_reset_password account, new_password
      server = account.server
      packet = account.password_reset_pack shell, new_password, account
      response = transportation_for packet, server
      account.analyse_password_reset response[0]
    end

    def self.pack_and_play_with_subscription subscription, customer_account
      server = customer_account.server
      packet = subscription.pack_this shell, customer_account
      response = transportation_for packet,server
      subscription.analyse response[0],customer_account
    end

    def self.pack_and_switch_subscription subscription, new_plan_guid, plesk_sub_id
      server = subscription.customer_account.server
      packet = subscription.switch_pack shell, new_plan_guid, plesk_sub_id
      response = transportation_for packet,server
      subscription.analyse response[0]
    end

    def self.sync_subscription sub, sub_guid, customer_account
      server = customer_account.server
      packet = sub.sync_pack shell,sub_guid
      response = transportation_for packet,server
      sub.analyse response[0]
    end

    def self.get_subscription_guid subscription
      packet = subscription.id_pack shell, subscription.name
      server = subscription.customer_account.server
      response = transportation_for(packet,server)
      subscription.analyse response[0]
    end

    def self.get_subscription_id subscription
      packet = subscription.id_pack shell, subscription.name
      server = subscription.customer_account.server
      response = transportation_for(packet,server)
      subscription.analyse_for_id response[0]
    end

    def self.get_service_plan service_plan, server
      packet = service_plan.build_xml_for_get shell
      response = transportation_for packet, server
      service_plan.analyse response[0], server
    end

    def self.get_subscription_usage(subscription,plesk_sub_id,server)
      packet = subscription.usage_pack shell, plesk_sub_id
      response = transportation_for packet, server
      subscription.analyse_usage response[0]
    end

    def self.push_service_plan service_plan, server
      packet = service_plan.build_xml_for_add shell
      response = transportation_for packet, server
      service_plan.analyse response[0], server
    end

    def self.push_windows_service_plan service_plan, server
      packet = service_plan.build_windows_xml_for_add shell
      response = transportation_for packet, server
      service_plan.analyse response[0], server
    end

    def self.get_server_stats server
      packet = server.pack_this shell
      response = transportation_for(packet,server)
      server.analyse_this response[0]
      #response[0]
    end

  end
end
