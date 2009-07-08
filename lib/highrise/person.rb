module Highrise
  class Person < Subject
    DATE_OCCASIONS = ["Birthday", "Anniversary", "First met", "Hired", "Fired"]
    
    include Pagination
    include Taggable
    
    def self.search_by_name(name)                                               
      find(:first, :from => "/people/search.xml", :params => {:term => name})
    end
    
    def self.find_all_by_tag(tag_name)
      tag = Tag.find_by_name(tag_name)
      find(:all, :from => "/tags/#{tag.id}.xml")
    end
    
    def self.find_all_across_pages_since(time)
      find_all_across_pages(:params => { :since => time.utc.to_s(:db).gsub(/[^\d]/, '') })
    end
  
    def company
      Company.find(company_id) if company_id
    end
  
    def name
      "#{first_name rescue ''} #{last_name rescue ''}".strip
    end
    

    def add_date!(description, date, task_owner_id=nil)
      description_key = DATE_OCCASIONS.include?(description) ? :description : :custom_description
      custom_date = { description_key => description, :month => date.month, :day => date.day, :year => date.year }
      if task_owner_id
        custom_date[:assign_task]   = true
        custom_date[:task_owner_id] = task_owner_id 
      end
      self.post(:contact_dates, :contact_date => custom_date)
    end
    
  end

end