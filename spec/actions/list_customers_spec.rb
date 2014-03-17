require 'spec_helper'

describe PleskLib::Actions::ListCustomers do
  let(:server) { PleskLib::Server.new('10.0.0.158', 'admin', 'ccsnDxnWy2j0') }

  it 'should return a statistics hash' do
    VCR.use_cassette 'server/list_customers', match_requests_on: [:method, :uri, :body] do
      action = PleskLib::Actions::ListCustomers.new
      customer_list = action.execute_on(server)

      customer_list.count.should == 4
      customer_list.each do |customer|
        customer.login.should_not be_empty
        customer.status.should == 0
      end
    end
  end
end
