class Notifier

  class Logger
    def initialize(response, recipient)
      @response = response
      @recipient = recipient
    end

    def self.log(response, recipient)
      new(response, recipient).log
    end

    def log
      @conversation = Conversation.new({
        date: DateTime.now,
        message: response[:body],
        to_number: response[:to],
        from_number: response[:from]
      })
      @conversation.recipients << @recipient
      @conversation.save
    end

    private

    attr_reader :response
    attr_reader :conversation
    
  end

  def initialize(recipient, smsmessage)
    @recipient, @smsmessage = recipient, smsmessage
  end

  def self.perform(recipient, smsmessage)
    new(recipient, smsmessage).perform
  end

  def perform
    Logger.log(attributes, recipient)
    client.account.sms.messages.create(attributes)
  end

  def attributes
    {
      from: from,
      to: to,
      body: body
    }
  end

  def self.log_notification(recipient, send_date)
    recipient.reports.each do |report|
      @notification = Notification.new
      @notification.report_id = report.id
      @notification.recipient_id = recipient.id
      @notification.send_date = send_date
      @notification.save
    end
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


  def account_sid
    ENV["TWILIO_SID"]
  end

  def account_token
    ENV["TWILIO_TOKEN"]
  end

  def client
    @client = Twilio::REST::Client.new(account_sid, account_token)
  end

  # @recipient.reports.each do |report|
  #         Notifier.perform(@recipient, "Your #{report.humanname} report is due #{@notification.send_date.to_s(:date_format)}. We will remind you one week before. Text STOP to stop these text messages.")
  #         if @notification.send_date < DateTime.now
  #           Notifier.perform(@recipient, "Your #{report.humanname} report is due on Monday, May 27th. Need help? Call (415) 558-1001.")
  #         else
  #           # use Notifier.new here so delayed job can hook into the perform method
  #           Delayed::Job.enqueue(Notifier.new(@recipient, "Your #{report.humanname} report is due #{@notification.send_date.to_s(:date_format)}. Need help? Call (415) 558-1001."), @notification.send_date)
  #         end
  #         @notification.report_id = report.id
  #         @notification.recipient_id = @recipient.id
  #         @notification.send_date = @notification.send_date
          
  #         @notification.save
  #       end

end