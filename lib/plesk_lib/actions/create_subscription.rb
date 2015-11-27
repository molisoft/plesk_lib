class PleskLib::Actions::CreateSubscription < PleskLib::Actions::Base
  attr_reader :subscription, :plesk_id, :guid

  def initialize(subscription)
    @subscription = subscription
  end

  #  Creates Object & Packet
  def build_xml
    xml = Builder::XmlMarkup.new
    xml.instruct!
    xml.packet {
      xml.webspace {
        xml.add {
          xml.gen_setup{
            xml.name(subscription.name)
            if subscription.owner_id.present?
              xml.tag!('owner-id', subscription.owner_id)
            end
            if subscription.owner_login.present?
              xml.tag!('owner-login', subscription.owner_login)
            end
            xml.ip_address(subscription.ip_address)
          }
          xml.hosting{
            xml.vrt_hst{
              xml.property{
                xml.name('ftp_login')
                xml.value(subscription.ftp_login)
              }
              xml.property{
                xml.name('ftp_password')
                xml.value(subscription.ftp_password)
              }
              xml.ip_address(subscription.ip_address)
            }
          }
          if subscription.service_plan_id.present?
            xml.tag!('plan-id', subscription.service_plan_id)
          end
          if subscription.service_plan_name.present?
            xml.tag!('plan-name', subscription.service_plan_name)
          end
        }
      }
    }
    xml.target!
  end

  def analyse(xml_document)
    add_node = xml_document.root.locate('*/result').first
    @plesk_id = add_node.id.text.to_i
    @guid = add_node.guid.text
  end
end
