require 'spec_helper'

describe PleskLib::Actions::GetStatistics do
  let(:server) { PleskLib::Server.new('10.0.0.158', 'admin', 'ccsnDxnWy2j0') }

  it 'should return a statistics hash' do
    VCR.use_cassette 'server/get_statistics', match_requests_on: [:method, :uri, :body] do
      action = PleskLib::Actions::GetStatistics.new
      return_value = action.execute_on(server)

      return_value.should_not be_empty
      return_value[:objects].should_not be_empty
    end
  end
end
