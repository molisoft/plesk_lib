# change customer plan.

class PleskLib::Actions::ChangeCustomerSubscriptionPlan < PleskLib::Actions::Base
  attr_reader :customer, :current_custiomer_subscription_id, :to_plan_guid

  def initialize(customer, current_custiomer_subscription_id, to_plan)
    @customer = customer
    @current_custiomer_subscription_id = current_custiomer_subscription_id
    @to_plan_guid = to_plan
  end

  def build_xml
    xml = Builder::XmlMarkup.new
    xml.instruct!
    xml.packet(:version => '1.6.3.5') {
      xml.webspace {
        xml.tag!('switch-subscription'){
          xml.filter{
            xml.id(@current_custiomer_subscription_id)
          }
          xml.tag!('plan-guid', @to_plan_guid)
        }
      }
    }
  end
end
