require 'spec_helper'

describe PleskLib::Actions::CreateServicePlan do
  let(:service_plan_config) { { mailboxes: 3, domains: 3, traffic: 3, storage: 3 } }
  let(:server) { PleskLib::Server.new('10.0.0.158', 'admin', 'ccsnDxnWy2j0') }
  let(:service_plan) { PleskLib::ServicePlan.new('An Admin Service Plan', service_plan_config) }

  it 'should create a service plan' do
    VCR.use_cassette 'service_plan/create_minimal', match_requests_on: [:method, :uri, :body] do
      action = PleskLib::Actions::CreateServicePlan.new(service_plan)
      action.execute_on(server)

      action.plesk_id.to_i.should > 0
      action.guid.length.should == 36 #guid is 36 characters long
    end
  end

  context 'when a reseller is given' do
    let(:service_plan_config) { { mailboxes: 3, domains: 3, traffic: 3,
                                  storage: 3, external_id: 'external-3',
                                  owner_id: 3 } }
    let(:service_plan) { PleskLib::ServicePlan.new('A New Reseller Service Plan', service_plan_config) }
    it 'should create a service plan for a reseller' do
      VCR.use_cassette 'service_plan/create_minimal_with_owner', match_requests_on: [:method, :uri, :body] do
        action = PleskLib::Actions::CreateServicePlan.new(service_plan)
        action.execute_on(server)

        action.plesk_id.to_i.should > 0
        action.guid.length.should == 36 #guid is 36 characters long
      end
    end
  end
end
