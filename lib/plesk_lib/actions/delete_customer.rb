# delete customer

class PleskLib::Actions::DeleteCustomer < PleskLib::Actions::Base
  attr_reader :customer

  def initialize(customer)
    @customer = customer
  end

  def build_xml
    xml = Builder::XmlMarkup.new
    xml.instruct!
    xml.packet {
      xml.customer {
        xml.del{
          xml.filter{
            xml.id(@customer.id)
          }
        }
      }
    }
  end
end
