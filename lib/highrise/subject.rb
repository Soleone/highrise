module Highrise
  class Subject < Base
    def notes
      Note.find_all_across_pages(:from => "/#{self.class.collection_name}/#{id}/notes.xml")
    end

    def emails
      Email.find_all_across_pages(:from => "/#{self.class.collection_name}/#{id}/emails.xml")
    end

    def upcoming_tasks
      Task.find(:all, :from => "/#{self.class.collection_name}/#{id}/tasks.xml")
    end
    
    def add_note!(note_body)
      return if note_body.blank?
      note = Note.new(:body => note_body)
      self.post(:notes, {}, note.to_xml)
    end
    
    def add_deal!(name, category, status=nil, background=nil)
      category_object = Deal::DealCategory.find_by_name(category)
      category_id = category_object ? category_object.id : nil
      deal = Deal.new(:name => name, :background => background, :status => status || "pending", :category_id => category_id)
      deal.price_type = 'fixed'
      deal.party_id   = self.id
      deal.save
    end

    def add_task!(body, due_date, arguments = {})
      category = Task::TaskCategory.find_by_name(arguments[:category])
      category_id = category ? category.id : nil

      task = Task.new(arguments.merge(:body => body, :category_id => category_id))

      if Task::DUE_DATES.include?(due_date.to_s)
        task.frame = due_date
      else
        task.frame = 'specific'
        task.due_at = due_date
      end

      task.subject_type = self.instance_of?(Kase) ? 'Kase' : 'Party'
      task.subject_id   = self.id
      task.save
    end
    
    
  end
end