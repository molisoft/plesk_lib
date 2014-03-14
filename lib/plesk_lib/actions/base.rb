require 'net/http'
require 'openssl'

module PleskLib::Actions
  class Base
      # executes the current method on a server
    def execute_on(server)
      xml = build_xml
      response = send_xml_to_server(server, xml)
      analyse(response[0])
    end

    protected

    # Sends packet to plesk
    def send_xml_to_server(server, xml)
      http = Net::HTTP.new(server.host, 8443)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      headers = {
          'HTTP_AUTH_LOGIN' => server.username,
          'HTTP_AUTH_PASSWD' => server.password,
          'Content-Type' => 'text/xml',
      }

      path = "/enterprise/control/agent.php"
      res, data = http.post2(path, xml, headers)
      return res.body, xml
    end
  end
end

