module PleskLib
  class ServicePlan
    attr_accessor :name, :mailboxes, :domains, :traffic, :storage, :external_id,
                  :owner_id, :id, :guid

    def initialize(name, attributes = {})
      @name = name
      attributes.each_pair do |key, value|
        send("#{key}=", value)
      end if attributes.present?
    end

    def to_s
      "#<#{self.class}: id=#{self.id} name=#{self.name}, guid: #{self.guid}>"
    end
  end
end
