module PleskKit
  class ResellerAccount < ActiveRecord::Base
    attr_accessible :cname, :login, :passwd, :pname

    has_many :subscriptions
    belongs_to :server

  end
end
