module PleskKit
  class CustomerAccount < ActiveRecord::Base
    attr_accessible :cname, :login, :passwd, :pname # TODO add plesk_id
    has_many :subscriptions
    belongs_to :server






    # # #
    # Methods for sending brand new customer account to Plesk
    # # #

    #  Creates Object & Packet
    def pack_this shell
      xml = shell
      xml.instruct!
      xml.packet(:version => '1.6.3.5') {
        xml.customer {
          xml.add{
            xml.gen_info{
              xml.cname(cname)
              xml.pname(pname)
              xml.login(login)
              xml.passwd(passwd)
              #xml.status(status ? 0 : 1)
              #xml.phone(phone)
              #xml.fax(fax)
              #xml.address(address)
              #xml.city(city)
              #xml.state(state)
              #xml.pcode(pcode)
              #xml.country(country)
            }
          }
        }
      }
      return xml.target!
    end

    def analyse response_string
      xml = REXML::Document.new(response_string)
      status = xml.root.elements['//status'].text if xml.root.elements['//status'].present?
      if status == "error"
        code = xml.root.elements['//errcode'].text
        message = xml.root.elements['//errtext'].text
        raise "#{code}: #{message}"
      else
        plesk_id = xml.root.elements['//id'].text if xml.root.elements['//id'].present?
      end
      return plesk_id # TODO save plesk_id
    end


    # # #
    # Methods for converting customer account to reseller account both locally and in Plesk
    # # #

    def convert_to_reseller
      nil
    end


  end
end
