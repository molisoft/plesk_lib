require 'spec_helper'

describe PleskLib::Customer do
  context 'with login and password given to intializer' do
    subject { PleskLib::Customer.new('the_login', { password: 'the_password' }) }

    it { should respond_to(:company_name) }
    it { should respond_to(:person_name) }
    it { should respond_to(:login) }
    it { should respond_to(:password) }

    its(:login) { should eql 'the_login' }
    its(:password) { should eql 'the_password' }

    it 'should be initializable with only the login' do
      expect {
        PleskLib::Customer.new('the_login')
      }.not_to raise_error
    end
  end
end
