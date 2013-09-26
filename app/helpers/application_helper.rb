module ApplicationHelper

  def is_active?(page_name)
    # binding.pry
    "active" if current_controller?(page_name)
  end
  
  def link_to_add_modal(param_name, tag_type, class = nil, )
    fields = content_tag(tag_type, name: param_name, id: param_name)
    link_to(name, '#', class: "add_modal btn", data: {id: id, fields: fields.gsub("\n", "")})
  end

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

  def chart_data(start_date, end_date = Date.today, date_field, model)
    (start_date..end_date).map do |date|
      {
        date: date.to_s(:date_format),
        number_sent: model.where("date(#{date_field}) = ?", date).count
      }
    end
  end

end
