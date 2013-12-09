module PleskKit
  class ResellerAccount < ActiveRecord::Base
    attr_accessible :cname, :login, :passwd, :pname, :plan_name, :service_plan_id, :server_id, :platform
    validate :uniqueness_of_login_across_accounts


    has_many :subscriptions
    belongs_to :server
    before_create :provision_in_plesk

    def provision_in_plesk
      PleskKit::Communicator.pack_and_play_with_customer_or_reseller self
    end

    # # #
    # Methods for sending brand new customer account to Plesk
    # # #

    #  Creates Object & Packet
    def pack_this shell
      xml = shell
      xml.instruct!
      xml.packet(:version => '1.6.3.5') {
        xml.reseller {
          xml.add{
            xml.tag!('gen-info') {
              xml.cname(self.cname)
              xml.pname(self.pname)
              xml.login(self.login)
              xml.passwd(self.passwd)
              #xml.status(status ? 0 : 1)
              #xml.phone(phone)
              #xml.fax(fax)
              #xml.address(address)
              #xml.city(city)
              #xml.state(state)
              #xml.pcode(pcode)
              #xml.country(country)
            }
            xml.tag!('plan-name', self.plan_name)
          }
        }
      }
      return xml.target!
    end

    def analyse response_string, server_id
      xml = REXML::Document.new(response_string)
      status = xml.root.elements['//status'].text if xml.root.elements['//status'].present?
      if status == "error"
        code = xml.root.elements['//errcode'].text
        message = xml.root.elements['//errtext'].text
        raise "#{code}: #{message}"
      else
        plesk_id = xml.root.elements['//id'].text if xml.root.elements['//id'].present?
        self.server_id = server_id
      end
      self.save
      return self # TODO save plesk_id
    end


    private
    def uniqueness_of_login_across_accounts
      if PleskKit::CustomerAccount.find_by_login(self.login).present?
        errors.add(:base, "Login is not unique across Uber Plesk accounts")
      elsif PleskKit::ResellerAccount.find_by_login(self.login).present?
        errors.add(:base, "Login is not unique across Uber Plesk accounts")
      end
    end
  end
end
