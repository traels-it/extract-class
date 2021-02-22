class SplitRecipients
  def initialize(recipients)
    @recipients = recipients
  end

  attr_reader :recipients

  def call
    split_recipients.map do |recipient|
      remove_whitespace(recipient)
    end
  end

  private

  def remove_whitespace(recipient)
    recipient.gsub(/\s+/, '')
  end

  def split_recipients
    recipients.split(/[\n,;]+/)
  end

end