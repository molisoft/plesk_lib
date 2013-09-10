module PleskKit
  class Subscription < ActiveRecord::Base
    attr_accessible :ip_address, :name, :owner_id, :owner_login, :plan_name, :service_plan_id

    belongs_to :customer_account
    belongs_to :reseller_account
    #belongs_to :service_plan
  end
end
