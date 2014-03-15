require 'plesk_lib/actions/base'
require 'builder'
require 'rexml/document'

class PleskLib::Actions::CreateAccount < PleskLib::Actions::Base
  def build_gen_info(xml, account)
    xml.gen_info{
      xml.cname(account.company_name)
      xml.pname(account.person_name)
      xml.login(account.login) if account.login.present?
      xml.passwd(account.password) if account.password.present?
      xml.status(account.status) if account.status.present?
      xml.phone(account.phone) if account.phone.present?
      xml.fax(account.fax) if account.fax.present?
      xml.address(account.address) if account.address.present?
      xml.city(account.city) if account.city.present?
      xml.state(account.state) if account.state.present?
      xml.pcode(account.pcode) if account.postal_code.present?
      xml.email(account.email) if account.email.present?
      xml.country(account.country) if account.country.present?
    }
    return xml.target!
  end

  def analyse(xml_document)
    if xml_document.root.elements['//id'].present?
      @plesk_id = xml_document.root.elements['//id'].text.to_i
    end
  end
end
