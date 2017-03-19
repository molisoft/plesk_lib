class PleskLib::Actions::ChangeCustomerLogin < PleskLib::Actions::Base
  attr_reader :customer, :new_login

  def initialize(customer, new_login)
    @customer = customer
    @new_login = new_login
  end

  def build_xml
    xml = Builder::XmlMarkup.new
    xml.instruct!
    xml.packet {
      xml.customer {
        xml.set{
          xml.filter{
            xml.login(@customer.login)
          }
          xml.values{
            xml.gen_info{
              xml.login(@new_login)
            }
          }
        }
      }
    }
  end
end
