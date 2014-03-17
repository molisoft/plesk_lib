class PleskLib::Actions::CreateCustomer < PleskLib::Actions::CreateAccount
  attr_reader :customer, :plesk_id

  def initialize(customer)
    @customer = customer
  end

  #  Creates Object & Packet
  def build_xml
    xml = Builder::XmlMarkup.new
    xml.instruct!
    xml.packet(:version => '1.6.3.5') {
      xml.customer {
        xml.add{
          build_gen_info(xml, @customer)
        }
      }
    }
    return xml.target!
  end
end
