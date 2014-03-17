class PleskLib::Actions::ListCustomers < PleskLib::Actions::Base
  MAPPING = {
    'cr_date' => 'created_at', 'cname' => 'company_name', 'pname' => 'person_name',
    'login' => 'login', 'status' => 'status', 'phone' => 'phone', 'fax' => 'fax',
    'email' => 'email', 'address' => 'address', 'city' => 'city', 'state' => 'state',
    'pcode' => 'postal_code', 'country' => 'country', 'locale' => 'locale',
    'guid' => 'guid', 'owner-id' => 'owner_id', 'vendor-guid' => 'vendor_guid',
    'external-id' => 'external_id', 'password' => 'password',
    'password_type' => 'password_type'
  }

  def build_xml
    xml = Builder::XmlMarkup.new
    xml.instruct!
    xml.packet(:version => '1.6.3.5') {
      xml.customer {
        xml.get {
          xml.filter
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
    customers = []
    xml_document.root.elements['//customer//get'].each_element do |el|
      customer = PleskLib::Customer.new(nil)
      el.elements['data//gen_info'].each_element do |attribute|
        customer_attribute = MAPPING[attribute.name]
        next if customer_attribute.blank? || !customer.respond_to?(customer_attribute) ||
                attribute.text.blank?
        customer.send("#{customer_attribute}=", attribute.text)
      end
      customer.status = customer.status.to_i
      customers << customer
    end
    customers
  end
end
