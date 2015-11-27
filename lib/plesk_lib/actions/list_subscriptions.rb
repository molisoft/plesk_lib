class PleskLib::Actions::ListSubscriptions < PleskLib::Actions::Base
  attr_reader :subscriptions

  def initialize(owner_id = nil)
    @owner_id = owner_id
  end

  def build_xml
    xml = Builder::XmlMarkup.new
    xml.instruct!
    xml.packet {
      xml.webspace {
        xml.get {
          xml.filter {
            xml.tag!('owner-id', @owner_id) if @owner_id.present?
          }
          xml.dataset {
            xml.gen_info
            xml.hosting
          }
        }
      }
    }
    return xml.target!
  end

  def analyse(xml_document)
    @subscriptions = []
    xml_document.root.webspace.get.nodes.each do |webspace_node|
      subscription = PleskLib::Subscription.new
      # binding.pry
      webspace_node.data.gen_info.nodes.each do |attribute_node|
        subscription_attribute = attribute_node.name.underscore
        next if !subscription.respond_to?(subscription_attribute) ||
                attribute_node.text.blank?
        subscription.send("#{subscription_attribute}=", attribute_node.text)
      end
      subscription.id = webspace_node.id.text.to_i
      @subscriptions << subscription
    end
  end
end
