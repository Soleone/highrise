module Highrise
  class Group < Base
    def self.find_by_name(name)
      find(:all).select{|category| category.name == name}.first
    end
  end
end