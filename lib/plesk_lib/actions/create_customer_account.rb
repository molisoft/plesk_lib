require 'plesk_lib'
require 'plesk_lib/actions/base'
require 'builder'

class PleskLib::Actions::CreateCustomerAccount < PleskLib::Actions::Base
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
          xml.gen_info{
            xml.cname(customer.company_name) if customer.company_name.present?
            xml.pname(customer.person_name) if customer.person_name.present?
            xml.login(customer.login) if customer.login.present?
            xml.passwd(customer.password) if customer.password.present?
            xml.status(customer.status) if customer.status.present?
            xml.phone(customer.phone) if customer.phone.present?
            xml.fax(customer.fax) if customer.fax.present?
            xml.address(customer.address) if customer.address.present?
            xml.city(customer.city) if customer.city.present?
            xml.state(customer.state) if customer.state.present?
            xml.pcode(customer.pcode) if customer.postal_code.present?
            xml.email(customer.email) if customer.email.present?
            xml.country(customer.country) if customer.country.present?
          }
        }
      }
    }
    return xml.target!
  end

  def analyse(response_string)
    xml = REXML::Document.new(response_string)
    status = xml.root.elements['//status'].text if xml.root.elements['//status'].present?
    if status == "error"
      code = xml.root.elements['//errcode'].text.to_i
      message = xml.root.elements['//errtext'].text
      case code
      when 1007 then
        raise PleskLib::LoginAlreadyTaken, message
      else
        raise "#{code}: #{message}"
      end
    else
      @plesk_id = xml.root.elements['//id'].text.to_i if xml.root.elements['//id'].present?
    end

    return @plesk_id
  end
end
