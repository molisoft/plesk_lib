class PleskLib::Actions::FindServicePlan < PleskLib::Actions::Base
  attr_reader :service_plan

  def initialize(service_plan)
    @service_plan = service_plan
  end

  def build_xml
    xml = Builder::XmlMarkup.new
    xml.instruct!
    xml.packet(:version => '1.6.3.0') {
      xml.tag!("service-plan") {
        xml.get{
          xml.filter{
            xml.name("#{service_plan.name}")
          }
        }
      }
    }
    return xml.target!
  end

  def analyse(xml_document)
    status = xml_document.root.elements['//status'].text if xml_document.root.elements['//status'].present?
    puts response_string
    if xml_document.root.elements['//get'].present?
      if status == 'error'
        if server.platform == 'linux'
          PleskLib::Communicator.push_service_plan self, server
        elsif server.platform == 'windows'
          PleskLib::Communicator.push_windows_service_plan self, server
        end
      elsif status == 'ok'
        return xml_document.root.elements['//guid'].text
      end

    elsif xml_document.root.elements['//add'].present?
      if status == "error"
        code = xml_document.root.elements['//errcode'].text
        message = xml_document.root.elements['//errtext'].text
        raise "#{code}: #{message}"
      elsif status == 'ok'
        return xml_document.root.elements['//guid'].text
     end
    end
  end
end
