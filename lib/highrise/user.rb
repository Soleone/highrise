module Highrise
  class User < Base
    def self.find_by_name(name)
      find(:all).select{|user| user.name == name}.first
    end
    
    def join(group)
      Membership.create(:user_id => id, :group_id => group.id)
    end
  end
end