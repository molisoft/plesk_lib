# change customer status.
# status values: 0 (active) | 16 (disabled_by admin) | 4 (under backup/restore) | 256 (expired)
# Only status values 0 and 16 can be set up.

CUSTOMER_STATUS_DISABLED = 16
CUSTOMER_STATUS_ACTIVE = 0

class PleskLib::Actions::ChangeCustomerStatus < PleskLib::Actions::Base
  attr_reader :customer, :status

  def initialize(customer, status)
    @customer = customer
    @status = status
  end

  def build_xml
    xml = Builder::XmlMarkup.new
    xml.instruct!
    xml.packet {
      xml.customer {
        xml.set{
          xml.filter{
            xml.id(@customer.id)
          }
          xml.values{
            xml.gen_info{
              xml.status(@status)
            }
          }
        }
      }
    }
  end
end
