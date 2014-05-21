class Notifier

  class Logger
    def initialize(response, recipient)
      @response = response
      @recipient = recipient
      # @batch_id = batch_id
    end

    def self.log(response, recipient)
      new(response, recipient).log
    end

    def log
      @conversation = Conversation.new({
        date: DateTime.now,
        message: response.body,
        to_number: response.to,
        from_number: response.from,
        message_id: response.sid,
        status: response.status
        # batch_id: @batch_id
      })
      @conversation.recipients << @recipient
      @conversation.save
    end

    private

    attr_reader :response
    attr_reader :conversation
    
  end

  def initialize(message_id, options ={})
      defaults = {
        group_id: nil,
        recipient_id: nil,
        organization_id: nil
      }
    options = defaults.merge(options)
    @recipient_id, @message_id, @group_id, @organization_id = options[:recipient_id], message_id, options[:group_id], options[:organization_id]
    @recipients = []
    if @group_id
      @group_id.each do |group|
        @group_recipients = Group.find_recipients_in_group(group)
        @group_recipients.each do |recipient|
          @recipients << recipient
        end
      end
    end
    if @recipient_id
      @recipients << Recipient.find(@recipient_id)
    end
  end

  def self.perform(message_id, options ={})
      defaults = {
        group_id: nil,
        recipient_id: nil
      }
      options = defaults.merge(options)
    new(message_id, group_id: options[:group_id], recipient_id: options[:recipient_id]).perform
  end

  def perform
    @recipients.each do |recipient|
      the_message = client.account.sms.messages.create(attributes(recipient))
      Logger.log(the_message, recipient)
    end
  end

  def attributes(recipient)
    {
      from: from,
      to: to(recipient),
      body: body,
    }
  end

  private

  attr_reader :recipient
  attr_reader :body

  def from
    Organization.find(@organization_id).phone_number ? Organization.find(@organization_id).phone_number : ENV["TWILIO_NUMBER"]
  end

  def to(recipient)
    recipient.phone
  end

  def body
    Message.find(@message_id).message_text
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