module PleskKit
  class Subscription < ActiveRecord::Base
    attr_accessible :ip_address, :name, :owner_id, :owner_login, :plan_name, :service_plan_id, :customer_account_id, :reseller_account_id

    belongs_to :customer_account
    belongs_to :reseller_account
    belongs_to :service_plan
    before_create :provision_in_plesk

    # TODO: doing checks before downgrades
    # box is returned in stat, it shoulds how many are consumed
    # real_size is returned in gen_info, it should show how big the entire subscription is... hopefully

    #request should look like this:
    #<packet version="1.6.3.0">
    #  <webspace>
    #    <get>
    #      <filter>
    #        <id>subscription_id.to_i</id>
    #      </filter>
    #      <gen_info>
    #      <stat/>
    #    </get>
    #  </webspace>
    #</packet>

    def provision_in_plesk
      account = (customer_account_id.present? ? customer_account : (reseller_account_id.present? ? reseller_account : raise(msg="no accounts?")))
      plan = PleskKit::ServicePlan.find_by_name self.plan_name
      self.service_plan_id = plan.id
      if plan.find_or_push(account.server).present?
        self.plan_name = self.plan_name
        self.ip_address = account.server.host
        self.owner_login = account.login
        self.name = self.name
        if account.class.to_s == 'PleskKit::ResellerAccount'
          self.reseller_account_id = account.id
        elsif account.class.to_s == 'PleskKit::CustomerAccount'
          self.customer_account_id = account.id
        end
        guid = PleskKit::Communicator.pack_and_play_with_subscription self, account
        PleskKit::Communicator.sync_subscription self, guid, account
        self.id
      else
        return false
      end
    end

    def downgradable?(new_plan)
      account = (customer_account_id.present? ? customer_account : (reseller_account_id.present? ? reseller_account : raise(msg="no accounts?")))
      mbox_limit = new_plan.mailboxes
      space_limit = new_plan.storage #this value is already bytes

      plesk_subscription_identifier = PleskKit::Communicator.get_subscription_id(self)
      usage = PleskKit::Communicator.get_subscription_usage(self,plesk_subscription_identifier, account.server)
      puts usage[0].to_i,usage[1].to_i
      if usage[0].to_i < space_limit.to_i && usage[1].to_i < mbox_limit.to_i
        true
      else
        false
      end
    end


    def usage_pack shell, plesk_sub_id
      xml = shell
      xml.instruct!
      xml.packet(:version => '1.6.3.0') {
        xml.webspace{
          xml.get {
            xml.filter{
              xml.id(plesk_sub_id)    # TODO!!!
            }
            xml.dataset {
              xml.gen_info
              xml.stat
            }
          }
        }
      }
    end

    # update the plan name attr here before switching
    def switch_in_plesk
      account = (customer_account_id.present? ? customer_account : (reseller_account_id.present? ? reseller_account : raise(msg="no accounts?")))
      plan = PleskKit::ServicePlan.find_by_name self.plan_name
      puts "|=|plan = PleskKit::ServicePlan.find_by_name self.plan_name ||| #{plan.inspect}"
      puts plan
      puts plan_name
      puts '_-_-_'
      plesk_subscription_identifier = PleskKit::Communicator.get_subscription_id(self)
      puts "plesk_subscription_identifier #{plesk_subscription_identifier}"
      if plan.find_or_push(account.server).present?
        #guid = PleskKit::Communicator.pack_and_play_with_subscription self, account
        guid = PleskKit::Communicator.get_service_plan plan, account.server
        puts "|=| THE GUID IS #{guid}"
        puts "|=| about to start the switch cmd"
        PleskKit::Communicator.pack_and_switch_subscription(self, guid, plesk_subscription_identifier)
        puts "|=| about to start the get_subscription_guid cmd"
        sub_guid = PleskKit::Communicator.get_subscription_guid(self)
        puts "|=| about to sync up"
        PleskKit::Communicator.sync_subscription self, sub_guid, self.customer_account
        true
      else
        puts "could not find or push?"
      end
    end

    def pack_this shell, customer
      digits = customer.login.to_s.split('')
      xx = ''
      digits.each {|d|xx << (d.to_i + 65).chr}
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
                  xml.value(xx.downcase)     #rand(36**8).to_s(36)
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

    def switch_pack shell, sub_guid, plesk_sub_id
      xml = shell
      xml.instruct!
      xml.packet(:version => '1.6.3.5') {
        xml.webspace{
          xml.send(:"switch-subscription") {
            xml.filter{
              xml.id(plesk_sub_id)    # TODO!!!
            }
            xml.tag! 'plan-guid', sub_guid
          }
        }
      }
    end

    def id_pack shell, domain_name
      xml = shell
      xml.instruct!
      xml.packet(:version => '1.6.3.5') {
        xml.webspace{
          xml.get{
            xml.filter{
              xml.name(domain_name)
            }
            xml.dataset{
              xml.gen_info
            }
          }
        }
      }
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

    def analyse_for_id response_string, customer = nil
      xml = REXML::Document.new(response_string)
      status = xml.root.elements['//status'].text if xml.root.elements['//status'].present?
      sub_guid =''
      if status == "error"
        code = xml.root.elements['//errcode'].text
        message = xml.root.elements['//errtext'].text
        raise "#{code}: #{message}"
      else
        sub_guid = xml.root.elements['//id'].text if xml.root.elements['//id'].present?
      end
      return sub_guid || true
    end

    def analyse_usage response_string
      xml = REXML::Document.new(response_string)
      status = xml.root.elements['//status'].text if xml.root.elements['//status'].present?
      space = ''
      mbox = ''
      if status == "error"
        code = xml.root.elements['//errcode'].text
        message = xml.root.elements['//errtext'].text
        raise "#{code}: #{message}"
      else
        space = xml.root.elements['//real_size'].text if xml.root.elements['//real_size'].present?
        mbox = xml.root.elements['//box'].text if xml.root.elements['//box'].present?
      end
      return [space,mbox]
    end

  end
end
