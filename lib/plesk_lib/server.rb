module PleskLib
  class Server
    attr_accessor :host, :password, :username

    def initialize(host, username, password)
      @host = host
      @username = username
      @password = password
    end

    def create_customer(customer)
      action = PleskLib::Actions::CreateCustomer.new(customer)
      action.execute_on(self)
    end

    def create_reseller(reseller)
      action = PleskLib::Actions::CreateReseller.new(reseller)
      action.execute_on(self)
    end

    def change_customer_password(customer, new_password)
      action = PleskLib::Actions::ChangeCustomerPassword.new(customer, new_password)
      action.execute_on(self)
    end

    def get_statistics
      action = PleskLib::Actions::GetStatistics.new
      action.execute_on(self)
    end
  end
end
