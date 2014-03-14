require 'spec_helper'
require 'plesk_lib/actions/create_customer_account'

describe PleskLib::Actions::CreateCustomerAccount do
  let(:customer_attributes) do
    { password: 'customer_secret', phone: '0000000000',
      email: 'noreply@ausupport.com.au', country: 'AU', person_name: 'Foo Bar' }
  end

  let(:server) { PleskLib::Server.new('10.0.0.158', 'admin', 'ccsnDxnWy2j0') }
  let(:customer) { PleskLib::CustomerAccount.new('user91', customer_attributes) }

  context 'when login is available on the plesk server' do
    it 'should create a customer account' do
      VCR.use_cassette 'customer_account/minimal', match_requests_on: [:method, :uri, :body] do
        action = PleskLib::Actions::CreateCustomerAccount.new(customer)
        return_value = action.execute_on(server)

        return_value.should eql 11
        action.plesk_id.should eql 11
      end
    end
  end

  context 'when login is already taken' do
    it 'should create a customer account' do
      VCR.use_cassette 'customer_account/minimal_exists', match_requests_on: [:method, :uri, :body] do
        action = PleskLib::Actions::CreateCustomerAccount.new(customer)
        expect {
          action.execute_on(server)
        }.to raise_error(PleskLib::LoginAlreadyTaken)
      end
    end
  end
end
