module PleskLib
  class CustomerAccount < ActiveRecord::Base
    attr_accessible :cname, :login, :passwd, :pname, :server_id, :platform # TODO add plesk_id
    has_many :subscriptions
    belongs_to :server
    validate :uniqueness_of_login_across_accounts
    before_create :provision_in_plesk

    def provision_in_plesk
      PleskLib::Communicator.pack_and_play_with_customer_or_reseller self
      true
    end

    def reset_password(new_password)
      PleskLib::Communicator.pack_and_reset_password self, new_password
      true
    end

    # # #
    # Methods for sending brand new customer account to Plesk
    # # #

    #  Creates Object & Packet
    def pack_this shell
      xml = shell
      xml.instruct!
      xml.packet(:version => '1.6.3.5') {
        xml.customer {
          xml.add{
            xml.gen_info{
              xml.cname(self.cname)
              xml.pname(self.pname)
              xml.login(self.login)
              xml.passwd(self.passwd)
              #xml.status(status ? 0 : 1)
              xml.phone('0000000000')
              #xml.fax(fax)
              #xml.address(address)
              #xml.city(city)
              #xml.state(state)
              #xml.pcode(pcode)
              xml.email('noreply@ausupport.com.au')
              xml.country("AU")
            }
          }
        }
      }
      return xml.target!
    end

    def password_reset_pack shell, new_password, account
      xml = shell
      xml.instruct!
      xml.packet(:version => '1.6.3.5') {
        xml.customer {
          xml.set{
            xml.filter{
              xml.login(account.login)
            }
            xml.values{
              xml.gen_info{
                xml.passwd(new_password)
              }
            }
          }
        }
      }
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
      #self.save
      return self # TODO save plesk_id
    end

    def analyse_password_reset response_string
      xml = REXML::Document.new(response_string)
      status = xml.root.elements['//status'].text if xml.root.elements['//status'].present?
      if status == "error"
        code = xml.root.elements['//errcode'].text
        message = xml.root.elements['//errtext'].text
        raise "#{code}: #{message}"
      else
        true
      end
    end

    private
    def uniqueness_of_login_across_accounts
      if PleskLib::CustomerAccount.find_by_login(self.login).present?
        errors.add(:base, "Login is not unique across Uber Plesk accounts")
      elsif PleskLib::ResellerAccount.find_by_login(self.login).present?
        errors.add(:base, "Login is not unique across Uber Plesk accounts")
      end
    end

  end
end
