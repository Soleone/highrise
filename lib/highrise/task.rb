module Highrise
  class Task < Base
    DUE_DATES = %w[today tomorrow this_week next_week later]
    
    # TODO: combine with DealCategory in a single model maybe
    class TaskCategory < Base
      def self.find_by_name(name)
        find(:all).select{|category| category.name == name}.first
      end

      def self.delete!(name)
        category = self.find_by_name(name)
        delete(category.id) if category
      end
    end
      
      
    # find(:all, :from => :upcoming)
    # find(:all, :from => :assigned)  
    # find(:all, :from => :completed)  

    def complete!
      load_attributes_from_response(post(:complete))
    end
  end
end