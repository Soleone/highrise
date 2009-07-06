module Highrise
  # name
  # background
  # status (pending, won, lost)
  # category-id
  # ---------------------------
  # account-id
  # author-id
  # created-at
  # currency
  # duration
  # group-id
  # owner-id
  # party-id
  # price type
  # price-type
  # responsible-party-id
  # status-changed-on
  # updated-at
  # visible-to
  class Deal < Subject
    
    class DealCategory < Base
      def self.find_by_name(name)
        find(:all).select{|category| category.name == name}.first
      end
      
      def self.delete!(name)
        category = self.find_by_name(name)
        delete(category.id) if category
      end
    end
    
  end
end