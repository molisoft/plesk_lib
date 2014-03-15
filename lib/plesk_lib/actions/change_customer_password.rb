require 'plesk_lib/actions/base'
require 'builder'
require 'rexml/document'

class PleskLib::Actions::ChangeCustomerPassword < PleskLib::Actions::Base
  attr_reader :customer, :new_password

  def initialize(customer, new_password)
    @customer = customer
    @new_password = new_password
  end

  def build_xml
    xml = Builder::XmlMarkup.new
    xml.instruct!
    xml.packet(:version => '1.6.3.5') {
      xml.customer {
        xml.set{
          xml.filter{
            xml.login(@customer.login)
          }
          xml.values{
            xml.gen_info{
              xml.passwd(@new_password)
            }
          }
        }
      }
    }
  end
end
