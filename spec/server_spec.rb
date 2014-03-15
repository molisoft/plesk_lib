require 'plesk_lib/server'

describe PleskLib::Server do
  subject { PleskLib::Server.new('10.0.0.1', 'admin', 'secret') }

  its(:host)     { should eql '10.0.0.1' }
  its(:username) { should eql 'admin'    }
  its(:password) { should eql 'secret'   }

  describe '#create_customer_account' do
    it 'uses the PleskLib::Actions::CreateCustomerAccount action' do
      customer_account = double(:customer_account)
      PleskLib::Actions::CreateCustomerAccount.should_receive(:new).with(customer_account).and_call_original
      PleskLib::Actions::CreateCustomerAccount.any_instance.should_receive(:execute_on).with(subject)

      subject.create_customer_account(customer_account)
    end
  end

  describe '#change_customer_account_password' do
    it 'uses the PleskLib::Actions::ChangeCustomerAccountPassword action' do
      customer_account = double(:customer_account)
      PleskLib::Actions::ChangeCustomerAccountPassword.should_receive(:new).with(customer_account, 'new_password').and_call_original
      PleskLib::Actions::ChangeCustomerAccountPassword.any_instance.should_receive(:execute_on).with(subject)

      subject.change_customer_account_password(customer_account, 'new_password')
    end
  end
end
