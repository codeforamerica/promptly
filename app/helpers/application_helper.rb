module ApplicationHelper
  
  # Standardizes the phone number
  def standardize_numbers(phone_number)
    unless phone_number == ""
      phone_number.phony_formatted!(:normalize => :US, :spaces => '')
    else
      phone_number = ""
    end
  end

  # Returns an array of recipient IDs.
  def parse_and_add_phone_numbers(phone_numbers_text)
    recipients_to_add = []
    phone_numbers_text.split("\r\n").each do |phone_number|
      #phone number normalization
      phone_number = standardize_numbers(phone_number)

      #save the recipients
      @recipient = Recipient.where(phone: phone_number).first_or_create
      @recipient.save
      unless recipient == ""
      end

      recipients_to_add << @recipient.id
    end
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
    # binding.pry
    (start_date..end_date).map do |date|
      {
        date: date.to_s(:date_format),
        number_sent: model.where("date(#{date_field}) = ?", date).count
      }
    end
  end

end
