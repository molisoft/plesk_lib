require 'spec_helper'

describe PleskLib::Actions::ChangeCustomerAccountPassword do
  let(:server) { PleskLib::Server.new('10.0.0.158', 'admin', 'ccsnDxnWy2j0') }

  context 'when user exists on the server' do
    let(:customer) { PleskLib::CustomerAccount.new('user91') }

    it 'should reset the customers password' do
      VCR.use_cassette 'customer_account/change_password_existing_user', match_requests_on: [:method, :uri, :body] do
        action = PleskLib::Actions::ChangeCustomerAccountPassword.new(customer, 'new_password')
        action.execute_on(server)
      end
    end
  end

  context 'when user is missing' do
    let(:customer) { PleskLib::CustomerAccount.new('unknownuser') }

    it 'should raise a CustomerAccountNotFound exception' do
      VCR.use_cassette 'customer_account/change_password_missing_user', match_requests_on: [:method, :uri, :body] do
        action = PleskLib::Actions::ChangeCustomerAccountPassword.new(customer, 'new_password')
        expect {
          action.execute_on(server)
        }.to raise_error(PleskLib::AccountNotFound)
      end
    end
  end
end
