class PleskLib::Actions::ListCustomers < PleskLib::Actions::Base
  attr_reader :customers

  MAPPING = {
    'cr_date' => 'created_at', 'cname' => 'company_name', 'pname' => 'person_name',
    'login' => 'login', 'status' => 'status', 'phone' => 'phone', 'fax' => 'fax',
    'email' => 'email', 'address' => 'address', 'city' => 'city', 'state' => 'state',
    'pcode' => 'postal_code', 'country' => 'country', 'locale' => 'locale',
    'guid' => 'guid', 'owner-id' => 'owner_id', 'vendor-guid' => 'vendor_guid',
    'external-id' => 'external_id', 'password' => 'password',
    'password_type' => 'password_type', 'id' => 'id',
  }

  def initialize(owner_id = nil)
    @owner_id = owner_id
  end

  def build_xml
    xml = Builder::XmlMarkup.new
    xml.instruct!
    xml.packet {
      xml.customer {
        xml.get {
          xml.filter {
            xml.tag!('owner-id', @owner_id) if @owner_id.present?
          }
          xml.dataset {
            xml.gen_info
            xml.stat
          }
        }
      }
    }
    return xml.target!
  end

  def analyse(xml_document)
    @customers = []
    xml_document.root.customer.get.nodes.each do |customer_node|
      customer = PleskLib::Customer.new(nil)
      customer_node.data.gen_info.nodes.each do |attribute_node|
        customer_attribute = MAPPING[attribute_node.name]
        next if customer_attribute.blank? || !customer.respond_to?(customer_attribute) ||
                attribute_node.text.blank?
        customer.send("#{customer_attribute}=", attribute_node.text)
      end
      customer.id = customer_node.id.text.to_i
      customer.status = customer.status.to_i
      @customers << customer
    end
  end
end
