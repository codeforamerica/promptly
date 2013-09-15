module ApplicationHelper
  
  def link_to_add_fields(name, f, association, child_association = nil)
    new_object = f.object.class.reflect_on_association(association).klass.new

    if child_association
      # 3.times{ new_object.send(child_association).build } #Builds 3 Answers
      # new_object.build(new_object.class.reflect_on_association(child_association)) #Builds 1 Answer
      new_object.send(child_association).build #Builds 1 Answer
      # new_object.class.build_child_association
    end
    id = new_object.object_id
    fields = f.fields_for(association, new_object) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields btn btn-default btn-small", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def countAggregateMessages(conversations, notifications)
    return conversations + notifications
  end

  def current_controller?(c)
    controller.controller_name == c
  end

  def upcoming_chart_data
    (Date.today..Date.today+2.weeks).map do |date|
      {
        send_date: date.to_s(:date_format),
        number_sent: Reminder.where("date(send_date) = ?", date).count
      }
    end
  end

  def sent_chart_data
    (2.weeks.ago.to_date..Date.today).map do |date|
      {
        sent_date: date.to_s(:date_format),
        number_sent: Conversation.where("date(date) = ?", date).count
      }
    end
  end

end
