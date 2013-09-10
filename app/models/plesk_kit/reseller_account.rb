module PleskKit
  class ResellerAccount < ActiveRecord::Base
    attr_accessible :cname, :login, :passwd, :pname

    has_many :subscriptions
    belongs_to :server

    def pack_this shell, customer_to_be_converted
      puts customer_to_be_converted.login
      xml = shell
      xml.instruct!
      xml.packet(:version => '1.6.3.5') {
        xml.customer {
          xml.tag!('convert-to-reseller') {
            xml.filter{
              xml.tag! 'owner-login', customer_to_be_converted.login
            }
          }
        }
      }
      return xml.target!
    end

    def analyse response_string, customer_to_be_converted
      xml = REXML::Document.new(response_string)
      status = xml.root.elements['//status'].text if xml.root.elements['//status'].present?
      if status == "error"
        code = xml.root.elements['//errcode'].text
        message = xml.root.elements['//errtext'].text
        raise "#{code}: #{message}"
      elsif status == "ok"
        plesk_id = xml.root.elements['//id'].text if xml.root.elements['//id'].present?
      else
        raise 500
      end
      return plesk_id # TODO save plesk_id
    end
  end
end
