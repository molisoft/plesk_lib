require 'spec_helper'

describe PleskLib::Actions::CreateSubscription do
  let(:server) { PleskLib::Server.new('10.0.0.158', 'admin', 'ccsnDxnWy2j0') }
  let(:subscription) { PleskLib::Subscription.new({ name: 'foo-domain.de',
                                                    ip_address: '10.0.0.158',
                                                    owner_id: 3,
                                                    service_plan_id: 10,
                                                    ftp_login: 'ftp01',
                                                    ftp_password: 'ftpPass01' }) }

  it 'should create a reseller' do
    VCR.use_cassette 'subscription/create', match_requests_on: [:method, :uri, :body] do
      action = PleskLib::Actions::CreateSubscription.new(subscription)
      action.execute_on(server)

      action.plesk_id.to_i.should > 0
      action.guid.length.should == 36
    end
  end
end
