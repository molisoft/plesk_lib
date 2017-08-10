# change customer status.
# status values: 0 (active) | 16 (disabled_by admin) | 4 (under backup/restore) | 256 (expired)
# Only status values 0 and 16 can be set up.

SUBSCRIPTION_STATUS_DISABLED = 32 # disabled by Plesk reseller
SUBSCRIPTION_STATUS_ACTIVE = 0

class PleskLib::Actions::ChangeCustomerSubscription < PleskLib::Actions::Base
  attr_reader :subscription_id, :name, :status

  def initialize(subscription_id, name=nil, status=nil)
    @subscription_id = subscription_id
    @name = name
    @status = status
  end

  def build_xml
    xml = Builder::XmlMarkup.new
    xml.instruct!
    xml.packet {
      xml.webspace {
        xml.set{
          xml.filter{
            xml.id(@subscription_id)
          }
          xml.values{
            xml.gen_setup{
              xml.tag!('name', @name) if @name.present?
              xml.tag!('status', @status) if @status.present?
            }
          }
        }
      }
    }
  end
end
