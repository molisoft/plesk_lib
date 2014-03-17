require 'spec_helper'

describe PleskLib::Actions::ListCustomers do
  let(:server) { PleskLib::Server.new('10.0.0.158', 'admin', 'ccsnDxnWy2j0') }

  it 'should list all customers' do
    VCR.use_cassette 'customer/list_customers', match_requests_on: [:method, :uri, :body] do
      action = PleskLib::Actions::ListCustomers.new
      action.execute_on(server)

      action.customers.count.should == 4
      action.customers.each do |customer|
        customer.login.should_not be_empty
        customer.status.should == 0
      end
    end
  end

  it 'should list customers of owner 3' do
    VCR.use_cassette 'customer/list_customers_filtered', match_requests_on: [:method, :uri, :body] do
      action = PleskLib::Actions::ListCustomers.new(3)
      action.execute_on(server)

      action.customers.count.should == 2
      action.customers.each do |customer|
        customer.login.should_not be_empty
        customer.status.should == 0
      end
    end
  end
end
