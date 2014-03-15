require 'plesk_lib/actions/create_account'
require 'builder'
require 'rexml/document'

class PleskLib::Actions::CreateReseller < PleskLib::Actions::CreateAccount
  attr_reader :reseller, :plesk_id

  def initialize(reseller)
    @reseller = reseller
  end

  #  Creates Object & Packet
  def build_xml
    xml = Builder::XmlMarkup.new
    xml.instruct!
    xml.packet(:version => '1.6.3.5') {
      xml.reseller {
        xml.add{
          build_gen_info(xml, @reseller, 'gen-info')
          xml.tag!('plan-id', @reseller.service_plan_id)
        }
      }
    }
    return xml.target!
  end
end
