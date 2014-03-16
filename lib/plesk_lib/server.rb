module PleskLib
  class Server
    attr_accessor :host, :password, :username

    def initialize(host, username, password)
      @host = host
      @username = username
      @password = password
    end

    def method_missing(method_name, *args)
      begin
        action_class = "PleskLib::Actions::#{method_name.to_s.camelize}".constantize
      rescue NameError => e
        raise NoMethodError, "The Action #{e.name} is not available. Please check the action docs."
      else
        action = action_class.new(*args)
        action.execute_on(self)
      end
    end
  end
end
