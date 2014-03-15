module PleskLib
  class Server
    attr_accessor :host, :password, :username

    def initialize(host, username, password)
      @host = host
      @username = username
      @password = password
    end

    def create_customer_account(customer_account)
      action = PleskLib::Actions::CreateCustomerAccount.new(customer_account)
      action.execute_on(self)
    end

    def change_customer_account_password(customer_account, new_password)
      action = PleskLib::Actions::ChangeCustomerAccountPassword.new(customer_account, new_password)
      action.execute_on(self)
    end

    def self.most_suitable_for_new_customer(platform)
      server_list = PleskLib::Server.where(:environment => Rails.env.to_s, :platform => platform)
      servers = []
      server_list.each { |s| servers << PleskLib::Communicator.get_server_stats(server=s) }
      servers = servers.sort_by { |hsh| hsh[:ram] }.reverse
      PleskLib::Server.find servers.first[:id]
    end

    def pack_this shell
      xml = shell
      xml.instruct!
      xml.packet(:version => '1.6.3.5') {
        xml.server{
          xml.get{
            xml.stat()
          }
        }
      }
      return xml.target!
    end

    def analyse_this response
      xml = REXML::Document.new(response)
      free_ram = cpu = nil
      ram = xml.root.elements['//mem']
      ram.each do |r|
        if r.name == 'free'
          free_ram = r.text
        end
      end
      cpu = xml.root.elements['//l15'].text
      return {id:self.id,ram:free_ram,cpu:cpu}
    end


  end
end
