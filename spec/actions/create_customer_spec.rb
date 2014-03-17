require 'spec_helper'

describe PleskLib::Actions::CreateCustomer do
  let(:customer_attributes) do
    { password: 'customer_secret', phone: '0000000000',
      email: 'noreply@ausupport.com.au', country: 'AU',
      person_name: 'FirstName LastName', company_name: 'My Company' }
  end

  let(:server) { PleskLib::Server.new('10.0.0.158', 'admin', 'ccsnDxnWy2j0') }
  let(:customer) { PleskLib::Customer.new('cust91', customer_attributes) }

  context 'when login is available on the plesk server' do
    it 'should create a customer' do
      VCR.use_cassette 'customer/minimal', match_requests_on: [:method, :uri, :body] do
        action = PleskLib::Actions::CreateCustomer.new(customer)
        action.execute_on(server)
        action.plesk_id.to_i.should > 0
      end
    end
  end

  context 'when an owner id is set' do
    let(:customer) { PleskLib::Customer.new('cust8891', customer_attributes) }
    let(:customer_attributes) do
      { password: 'customer_secret', phone: '0000000000',
        email: 'noreply@ausupport.com.au', country: 'AU',
        person_name: 'FirstName LastName', company_name: 'My Company',
        owner_id: 3 }
    end
    it 'should create a customer' do
      VCR.use_cassette 'customer/minimal_with_owner', match_requests_on: [:method, :uri, :body] do
        action = PleskLib::Actions::CreateCustomer.new(customer)
        action.execute_on(server)
        action.plesk_id.to_i.should > 0
      end
    end
  end

  context 'when login is already taken' do
    it 'should raise a LoginAlreadyTaken exception' do
      VCR.use_cassette 'customer/minimal_exists', match_requests_on: [:method, :uri, :body] do
        action = PleskLib::Actions::CreateCustomer.new(customer)
        expect {
          action.execute_on(server)
        }.to raise_error(PleskLib::LoginAlreadyTaken)
      end
    end
  end
end
