require 'spec_helper'

describe PleskLib::Actions::ListSubscriptions do
  let(:server) { PleskLib::Server.new('10.0.0.158', 'admin', 'ccsnDxnWy2j0') }

  it 'should list all subscriptions' do
    VCR.use_cassette 'subscription/list_subscriptions', match_requests_on: [:method, :uri, :body] do
      action = PleskLib::Actions::ListSubscriptions.new
      action.execute_on(server)

      action.subscriptions.count.should == 3
      action.subscriptions.each do |subscription|
        subscription.id.to_i.should > 0
        subscription.guid.length.should == 36
      end
    end
  end

  it 'should list subscriptions of owner 4' do
    VCR.use_cassette 'subscription/list_subscriptions_filtered', match_requests_on: [:method, :uri, :body] do
      action = PleskLib::Actions::ListSubscriptions.new(4)
      action.execute_on(server)

      action.subscriptions.count.should == 2
      action.subscriptions.each do |subscription|
        subscription.id.to_i.should > 0
        subscription.guid.length.should == 36
      end
    end
  end
end
