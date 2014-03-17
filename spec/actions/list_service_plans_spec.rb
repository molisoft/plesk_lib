require 'spec_helper'

describe PleskLib::Actions::ListServicePlans do
  let(:server) { PleskLib::Server.new('10.0.0.158', 'admin', 'ccsnDxnWy2j0') }

  it 'should list all service plans' do
    VCR.use_cassette 'service_plan/list_all', match_requests_on: [:method, :uri, :body] do
      action = PleskLib::Actions::ListServicePlans.new
      action.execute_on(server)

      action.service_plans.count.should == 9
      action.service_plans.each do |service_plan|
        service_plan.id.should be_present
        service_plan.guid.length.should == 36
      end
    end
  end

  it 'should list the admin service plans' do
    VCR.use_cassette 'service_plan/list_admin', match_requests_on: [:method, :uri, :body] do
      action = PleskLib::Actions::ListServicePlans.new(1)
      action.execute_on(server)

      action.service_plans.count.should == 6
      action.service_plans.each do |service_plan|
        service_plan.id.should be_present
        service_plan.guid.length.should == 36
      end
    end
  end
end
