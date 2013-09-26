class Notifier

  class Logger
    def initialize(response, recipient, batch_id)
      @response = response
      @recipient = recipient
      @batch_id = batch_id
    end

    def self.log(response, recipient, batch_id)
      new(response, recipient, batch_id).log
    end

    def log
      @conversation = Conversation.new({
        date: DateTime.now,
        message: response.body,
        to_number: response.to,
        from_number: response.from,
        message_id: response.sid,
        status: response.status,
        batch_id: batch_id
      })
      @conversation.recipients << @recipient
      @conversation.save
    end

    private

    attr_reader :response
    attr_reader :conversation
    
  end

  def initialize(recipient, smsmessage, batch_id)
    @recipient, @smsmessage, @batch_id = recipient, smsmessage, batch_id
  end

  def self.perform(recipient, smsmessage, batch_id)
    new(recipient, smsmessage, batch_id).perform
  end

  def perform
    the_message = client.account.sms.messages.create(attributes)
    Logger.log(the_message, recipient, batch_id)
  end

  def attributes
    {
      from: from,
      to: to,
      body: body,
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

  def body
    @smsmessage
  end

  def batch_id
    @batch_id
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