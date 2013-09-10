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
    def self.pack_and_play_with s, customer_to_be_converted = nil
      if customer_to_be_converted.blank?
        #TODO server = PleskKit::Server.most_suitable_for_new_customer
        packet = s.pack_this shell
        response = transportation_for packet #TODO here add server
        #TODO associate server to the customer account?
        s.analyse response[0] # Any specific returns, db updates, or response error handling happens here. Can also programatically detect what happened here based on the response as it verifies the command performed.
      else
        packet = s.pack_this shell, customer_to_be_converted
        #response = transportation_for(packet)
        #s.analyse response[0],customer_to_be_converted
      end
    end

    #  Sends Packet to Plesk # TODO consider how PleskKit::Server interacts here? Does the user select one, or is the one matching the environment with the fewest customers selected? Prob the latter...
    def self.transportation_for packet
      c = PleskKit::Client.new
      c.send_to_plesk packet
      # TODO associate account to server
    end
  end
end