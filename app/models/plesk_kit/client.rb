module PleskKit
  class Client
    attr_accessor :host, :user, :pass, :timeout, :rpc_version, :xml_response, :xml_target
    def initialize(host='117.55.235.7', user='admin', pass='Lay3Rcak3o9', timeout = 30) #TODO get these from server object?
      @host, @user, @pass, @timeout = host, user, pass, timeout
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