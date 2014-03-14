require 'plesk_lib/server'

describe PleskLib::Server do
  context 'with host, username and password' do
    subject { PleskLib::Server.new('10.0.0.1', 'admin', 'secret') }

    it { should respond_to(:host) }
    it { should respond_to(:username) }
    it { should respond_to(:password) }

    its(:host)     { should eql '10.0.0.1' }
    its(:username) { should eql 'admin'    }
    its(:password) { should eql 'secret'   }
  end
end
