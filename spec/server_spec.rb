require 'spec_helper'

describe PleskLib::Server do
  subject { PleskLib::Server.new('10.0.0.1', 'admin', 'secret') }

  its(:host)     { should eql '10.0.0.1' }
  its(:username) { should eql 'admin'    }
  its(:password) { should eql 'secret'   }

  describe '#create_customer' do
    it 'uses the PleskLib::Actions::CreateCustomer action' do
      customer = double(:customer)
      PleskLib::Actions::CreateCustomer.should_receive(:new).with(customer).and_call_original
      PleskLib::Actions::CreateCustomer.any_instance.should_receive(:execute_on).with(subject)

      subject.create_customer(customer)
    end
  end

  describe '#create_reseller' do
    it 'uses the PleskLib::Actions::CreateReseller action' do
      reseller = double(:reseller)
      PleskLib::Actions::CreateReseller.should_receive(:new).with(reseller).and_call_original
      PleskLib::Actions::CreateReseller.any_instance.should_receive(:execute_on).with(subject)

      subject.create_reseller(reseller)
    end
  end

  describe '#change_customer_password' do
    it 'uses the PleskLib::Actions::ChangeCustomerPassword action' do
      customer = double(:customer)
      PleskLib::Actions::ChangeCustomerPassword.should_receive(:new).with(customer, 'new_password').and_call_original
      PleskLib::Actions::ChangeCustomerPassword.any_instance.should_receive(:execute_on).with(subject)

      subject.change_customer_password(customer, 'new_password')
    end
  end

  describe '#get_statistics' do
    it 'uses the PleskLib::Actions::GetStatistics action' do
      PleskLib::Actions::GetStatistics.should_receive(:new).and_call_original
      PleskLib::Actions::GetStatistics.any_instance.should_receive(:execute_on).with(subject)

      subject.get_statistics
    end
  end
end
