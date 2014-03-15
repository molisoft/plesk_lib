require 'plesk_lib/actions/base'
require 'builder'
require 'rexml/document'

class PleskLib::Actions::CreateCustomer < PleskLib::Actions::Base
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
            xml.cname(customer.company_name)
            xml.pname(customer.person_name)
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

  def analyse(xml_document)
    if xml_document.root.elements['//id'].present?
      @plesk_id = xml_document.root.elements['//id'].text.to_i
    end
  end
end
