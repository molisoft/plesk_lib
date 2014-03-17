require 'net/http'
require 'openssl'

module PleskLib::Actions
  class Base
      # executes the current method on a server
    def execute_on(server)
      request_xml = build_xml
      response_xml = send_xml_to_server(server, request_xml)
      response_document = REXML::Document.new(response_xml)
      parse_errors(response_document)
      analyse(response_document)
      return true
    end

    protected

    def parse_errors(xml_document)
      status = xml_document.root.elements['//status'].text if xml_document.root.elements['//status'].present?
      return unless status == "error"
      code = xml_document.root.elements['//errcode'].text.to_i
      message = xml_document.root.elements['//errtext'].text

      # this catches the duplicate account error for resellers
      if code == 1019 and message.include?('already exists')
        raise PleskLib::LoginAlreadyTaken, message
      end

      case code
      when 1007 then
        raise PleskLib::LoginAlreadyTaken, message
      when 1013 then
        raise PleskLib::AccountNotFound, message
      else
        raise "#{code}: #{message}"
      end
    end

    def analyse(xml_document)
      return true
    end

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
      return res.body
    end
  end
end

