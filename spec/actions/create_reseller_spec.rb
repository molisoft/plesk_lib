require 'spec_helper'

describe PleskLib::Actions::CreateReseller do
  let(:reseller_attributes) do
    { password: 'reseller_secret', phone: '0000000000',
      email: 'noreply@ausupport.com.au', country: 'AU',
      person_name: 'Reseller Name', company_name: 'Reseller Company',
      service_plan_id: 2 }
  end

  let(:server) { PleskLib::Server.new('10.0.0.158', 'admin', 'ccsnDxnWy2j0') }
  let(:reseller) { PleskLib::Reseller.new('reseller99', reseller_attributes) }

  context 'when login is available on the plesk server' do
    it 'should create a reseller' do
      VCR.use_cassette 'reseller/minimal', match_requests_on: [:method, :uri, :body] do
        action = PleskLib::Actions::CreateReseller.new(reseller)
        action.execute_on(server)

        action.plesk_id.to_i.should > 0
      end
    end
  end

  context 'when login is already taken' do
    it 'should raise a LoginAlreadyTaken exception' do
      VCR.use_cassette 'reseller/minimal_exists', match_requests_on: [:method, :uri, :body] do
        action = PleskLib::Actions::CreateReseller.new(reseller)
        expect {
          action.execute_on(server)
        }.to raise_error(PleskLib::LoginAlreadyTaken)
      end
    end
  end
end
