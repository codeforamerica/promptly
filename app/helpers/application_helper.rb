module ApplicationHelper

  def is_active?(page_name)
    "active" if current_controller?(page_name)
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
    date_field_sym = date_field.to_sym
    if model.kind_of?(Array)
      multi_data(start_date, end_date = Date.today, date_field_sym, model)
    else
        (start_date..end_date).map do |date|
        {
          date: date,
          #to_datetime > midnight
          #Using midnight-midnight range gets around using date() sql function to cast dates,
          #which doesn't work on SQLServer 08 
          number_sent: model.order(date_field_sym)
                        .where(date_field_sym => date.to_datetime..(date+1).to_datetime)
                        .count
        }
      end
    end

  end

  def multi_data(start_date, end_date = Date.today, date_field_sym, model)
    graph_data = []
    (start_date.year..end_date.year).map do |date|
      data = {}
      data["date"] = date
      the_year = Date.new(date, 1)
      the_next_year = Date.new(date+1, 1)
      model.each_with_index.reduce({}) do |memo, (response, count)|
        memo = response.order(date_field_sym)
                          .where("date >= ? and date < ?",  the_year, the_next_year)
                          .count
        data["number_sent"+count.to_s] = memo
      end
      graph_data.push(data)
    end
    graph_data
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
end
