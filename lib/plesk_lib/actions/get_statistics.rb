class PleskLib::Actions::GetStatistics < PleskLib::Actions::Base
  attr_reader :statistics

  def build_xml
    xml = Builder::XmlMarkup.new
    xml.instruct!
    xml.packet(:version => '1.6.3.5') {
      xml.server{
        xml.get{
          xml.stat()
        }
      }
    }
    return xml.target!
  end

  def analyse(xml_document)
    @statistics = {}
    object_stats = {}
    device_stats = {}

    xml_document.root.elements['//stat//objects'].each_element do |element|
      object_stats[element.name] = element.text.to_i
    end

    xml_document.root.elements['//stat//load_avg'].each_element do |element|
      @statistics[element.name] = element.text.to_f / 100
    end

    xml_document.root.elements['//stat//mem'].each_element do |element|
      @statistics['mem_' + element.name] = BigDecimal.new(element.text)
    end

    xml_document.root.elements['//stat//swap'].each_element do |element|
      @statistics['swap_' + element.name] = BigDecimal.new(element.text)
    end

    xml_document.root.elements['//stat//diskspace'].each_element do |device_node|
      device_name = nil, device_attrs = {}
      device_node.each_element do |attr_node|
        if attr_node.name == 'name'
          device_name = attr_node.text
        else
          device_attrs[attr_node.name] = BigDecimal.new(attr_node.text)
        end
      end
      device_stats[device_name] = device_attrs
    end

    text_elements = xml_document.root.elements['//stat//version'].to_a + xml_document.root.elements['//stat//other'].to_a
    text_elements.each do |element|
      @statistics[element.name] = element.name == 'uptime' ? element.text.to_i : element.text
    end
    @statistics.merge!({objects: object_stats, devices: device_stats})
  end
end
