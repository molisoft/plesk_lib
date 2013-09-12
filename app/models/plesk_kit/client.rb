module PleskKit
  class Client
    attr_accessor :host, :user, :pass, :timeout, :rpc_version, :xml_response, :xml_target
    def initialize(server)
      @host, @user, @pass, @timeout = server.host, server.username, server.password, 30
    end

    def send_to_plesk(xml)
      http = Net::HTTP.new(@host, 8443)
      puts http.inspect
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      @headers = {
          'HTTP_AUTH_LOGIN' => @user,
          'HTTP_AUTH_PASSWD' => @pass,
          'Content-Type' => 'text/xml',
      }
      puts @headers
      path = "/enterprise/control/agent.php"
      res, data = http.post2(path, xml, @headers)
      puts res
      return res.body, xml
    end
  end
end