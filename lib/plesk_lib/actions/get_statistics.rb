class PleskLib::Actions::GetStatistics < PleskLib::Actions::Base
  attr_reader :statistics

  def build_xml
    xml = Builder::XmlMarkup.new
    xml.instruct!
    xml.packet {
      xml.server{
        xml.get{
          xml.stat()
        }
      }
    }
    return xml.target!
  end

  def analyse(xml_document)
    status_root = xml_document.root.server.get.result.stat
    @statistics = {}
    object_stats = {}
    device_stats = {}

    status_root.objects.nodes.each do |node|
      object_stats[node.name] = node.text.to_i
    end

    status_root.load_avg.nodes.each do |node|
      @statistics[node.name] = node.text.to_f / 100
    end

    status_root.mem.nodes.each do |node|
      @statistics['mem_' + node.name] = BigDecimal.new(node.text)
    end

    status_root.swap.nodes.each do |node|
      @statistics['swap_' + node.name] = BigDecimal.new(node.text)
    end

    status_root.diskspace.nodes.each do |device_node|
      device_name = nil, device_attrs = {}
      device_node.nodes.each do |attr_node|
        if attr_node.name == 'name'
          device_name = attr_node.text
        else
          device_attrs[attr_node.name] = BigDecimal.new(attr_node.text)
        end
      end
      device_stats[device_name] = device_attrs
    end

    status_root.version.nodes.each do |node|
      @statistics[node.name] = node.text
    end

    status_root.other.nodes.each do |node|
      @statistics[node.name] = node.name == 'uptime' ? node.text.to_i : node.text
    end

    @statistics.merge!({objects: object_stats, devices: device_stats})
  end
end
