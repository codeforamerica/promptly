class Notifier

  class Logger
    def initialize(respone)
      @response = response
    end

    def self.log(response)
      new(response).log
    end

    def log
      # logging logic
      @conversation = Conversation.new
      @conversation.date = response.date
      @conversation.message = response.body
      @conversation.to_number = response.to
      @conversation.from_number = response.from
      @conversation.save
    end

    private

    attr_reader :response

  end

  def initialize(reminder)
    @reminder = reminder
  end

  def self.perform(reminder)
    new(reminder).perform
  end

  def perform
    client.account.sms.messages.create(attributes).tap do |response|
      Logger.log(response) #if response.valid?
    end
  end

  def attributes
    {
      from: from,
      to: to,
      body: body
    }
  end

  private

  attr_reader :reminder


  def from
    reminder.from_number
  end

  def to
    reminder.to_number
  end

  def body
    reminder.body
  end

   def date
    reminder.date
  end

  def account_sid
    ENV["TWILIO_SID"]
  end

  def account_token
    ENV["TWILIO_TOKEN"]
  end

  def client
    @client = Twilio::REST::Client.new(account_sid, account_token)
  end

end