module PleskKit
  class Subscription < ActiveRecord::Base
    attr_accessible :ip_address, :name, :owner_id, :owner_login, :plan_name, :service_plan_id, :customer_account_id, :reseller_account_id

    belongs_to :customer_account
    belongs_to :reseller_account
    #belongs_to :service_plan
    before_create :provision_in_plesk

    def provision_in_plesk
      account = (customer_account_id.present? ? customer_account : (reseller_account_id.present? ? reseller_account : raise(msg="no accounts?")))
      self.plan_name = self.plan_name
      self.ip_address = '117.55.235.27'
      self.owner_login = account.login
      self.name = self.name
      if account.class.to_s == 'PleskKit::ResellerAccount'
        self.reseller_account_id = account.id
      elsif account.class.to_s == 'PleskKit::CustomerAccount'
        self.customer_account_id = account.id
      end
      guid = PleskKit::Communicator.pack_and_play_with self, account
      PleskKit::Communicator.sync_subscription self, guid
      self.id
    end

    def pack_this shell, customer
      xml = shell
      xml.instruct!
      xml.packet(:version => '1.6.3.5') {
        xml.webspace {
          xml.add{
            xml.gen_setup{
              xml.name(self.name)
              xml.tag! 'owner-login', self.owner_login
              xml.ip_address(self.ip_address)
            }
            xml.hosting{
              xml.vrt_hst{
                xml.property{
                  xml.name('ftp_login')
                  xml.value("#{customer.login}#{(0...4).map{  ('a'..'z').to_a[rand(26)] }.join}")
                }
                xml.property{
                  xml.name('ftp_password')
                  xml.value(customer.passwd)
                }
                xml.ip_address(self.ip_address)
              }
            }
            xml.tag! 'plan-name', self.plan_name
          }
        }
      }
      puts xml.target!
      return xml.target!
    end

    def sync_pack shell, sub_guid
      xml = shell
      xml.instruct!
      xml.packet(:version => '1.6.3.5') {
        xml.webspace{
          xml.send(:"sync-subscription") {
            xml.filter{
              xml.guid(sub_guid)
            }
          }
        }
      }
    end

    def analyse response_string, customer = nil
      xml = REXML::Document.new(response_string)
      status = xml.root.elements['//status'].text if xml.root.elements['//status'].present?
      if status == "error"
        code = xml.root.elements['//errcode'].text
        message = xml.root.elements['//errtext'].text
        raise "#{code}: #{message}"
      else
        sub_guid = xml.root.elements['//guid'].text if xml.root.elements['//guid'].present?
      end
      return sub_guid || true # TODO save plesk_id? Probably not necessary as we have the customer login
    end

  end
end
