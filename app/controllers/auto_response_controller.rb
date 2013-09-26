class AutoResponseController < ApplicationController

  #no layouts because we're just returning TwiML
  layout false

  def handle_incoming_call
  end
  
  def handle_input
    input = params['Digits']
    if input == '1'
      render 'english_response'
    elsif input == '2'
      render 'spanish_response'
    elsif input == '3'
      render 'cantonese_response'
    else
      #default to english if invalid input
      render 'english_response'
    end
  end

  def english_response
  end

  def spanish_response
  end

  def cantonese_response
  end

  def handle_incoming_sms
  end
end


# resp = twilio.twiml.Response()
#   with resp.gather(action="/handle-user-input", numDigits="1", method="GET") as ga:
#     ga.say(render_template('waiver.html'))
#   return str(resp)