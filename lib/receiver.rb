class Receiver
  include Helper

  class Logger
    def initialize(response, recipient)
      @response = response
      @recipient = recipient
    end

    def self.log(response, recipient = nil)
      if recipient
        new(response, recipient).log
      else
        new(response, recipient = nil).log
      end
    end

    def log
      @conversation = Conversation.new({
        date: DateTime.now,
        message: response.body,
        to_number: response.to,
        from_number: response.from,
        message_id: response.sid
      })
      if @recipient
        @conversation.recipients << @recipient
      end
      @conversation.save
    end

    private

    attr_reader :response
    attr_reader :conversation
    
  end

  def initialize
  end

  def self.perform
    new.perform
  end

  def perform
    @account = client.account
    # :date_sent => DateTime.now.strftime("%Y-%m-%d")
    # binding.pry
    # Loop over messages sent to our twilio number and only for today
    @account.sms.messages.list(:to=>"+14154198992", :date_sent => DateTime.now.strftime("%Y-%m-%d")).each do |message|
      if current_user_exists?(message.from).empty?
        Logger.log(message)
        response = client.account.sms.messages.create(
          :from => ENV["TWILIO_NUMBER"],
          :to => message.from,
          :body => "Hi, looks like you are trying to get a hold of us. %0aGive us a call at (877) 366-3076 and we can help you. Thanks.")
        Logger.log(response)
      else
        # hitting the current_user_exists method too many times. ******** NEED TO REFACTOR
        Logger.log(message, current_user_exists?(message.from))
        # should we have a limit here? if we already sent 5 message, send something special or just don't send anything?
        check_datetime = Date.today - 1.day
        unless Conversation.where("from_number = ? and message_id = ?", message.from, message.sid)
          response = client.account.sms.messages.create(
            :from => ENV["TWILIO_NUMBER"],
            :to => message.from,
            :body => "Hi, looks like you are trying to get in touch with us. %0aGive us a call at (877) 366-3076 and we can help you. Thanks.")
          Logger.log(response, current_user_exists?(message.from))
        end
      end
    end
    Receiver.delay(priority: 1, run_at: 2.minutes.from_now).perform
  end

  private

  attr_reader :recipient
  attr_reader :body

  def account_sid
    ENV["TWILIO_SID"]
  end

  def account_token
    ENV["TWILIO_TOKEN"]
  end

  def client
    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new(account_sid, account_token)
  end

end