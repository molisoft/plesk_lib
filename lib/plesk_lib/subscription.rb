module PleskLib
  class Subscription
    attr_accessor :id, :ip_address, :name, :owner_id, :owner_login,
                  :service_plan_name, :service_plan_id, :customer_account_id,
                  :reseller_account_id, :external_id, :guid, :vendor_guid,
                  :ftp_login, :ftp_password

    def initialize(attributes = {})
      attributes.each_pair do |key, value|
        send("#{key}=", value)
      end if attributes.present?
    end
  end
end
