class PleskLib::Actions::ListServicePlans < PleskLib::Actions::Base
  attr_reader :service_plans

  def initialize(owner_id = nil)
    @owner_id = owner_id
  end

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
      xml.tag!('service-plan') {
        xml.get {
          xml.filter
          if @owner_id.present?
            xml.tag!('owner-id', @owner_id)
          else
            xml.tag!('owner-all')
          end
        }
      }
    }
    return xml.target!
  end

  def analyse(xml_document)
    @service_plans = []
    xml_document.root.elements['//service-plan//get'].each_element do |plan_el|
      service_plan = PleskLib::ServicePlan.new(plan_el.elements['name'].text)
      # binding.pry
      service_plan.id = plan_el.elements['id'].text.to_i
      service_plan.external_id = plan_el.elements['external-id'].text
      service_plan.guid = plan_el.elements['guid'].text

      owner_id_el = plan_el.elements['owner-id']
      if owner_id_el.present?
        service_plan.owner_id = owner_id_el.text.to_i
      end

      # plan_el.elements['data//gen_info'].each_element do |attribute|
      #   service_plan_attribute = MAPPING[attribute.name]
      #   next if service_plan_attribute.blank? || !service_plan.respond_to?(service_plan_attribute) ||
      #           attribute.text.blank?
      #   service_plan.send("#{service_plan_attribute}=", attribute.text)
      # end
      # service_plan.status = service_plan.status.to_i
      @service_plans << service_plan
    end
  end
end
