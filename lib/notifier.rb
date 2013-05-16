class Notifier

  class Logger
    def initialize(response)
      @response = response
    end

    def self.log(response)
      new(response).log
    end

    def log
      @conversation = Conversation.new({
        date: DateTime.now,
        message: response[:body],
        to_number: response[:to],
        from_number: response[:from]
      })
      @conversation.save
    end

    private

    attr_reader :response
    attr_reader :conversation
    
  end

  def initialize(recipient, body)
    @recipient, @body = recipient, body
  end

  def self.perform(recipient, body)
    new(recipient, body).perform
  end

  def perform
    Logger.log(attributes)
    client.account.sms.messages.create(attributes).tap do |response|
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

  attr_reader :recipient
  attr_reader :body

  def from
    ENV["TWILIO_NUMBER"]
  end

  def to
    recipient.phone
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