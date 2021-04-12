# Despite our best intentions, this class has acquired too many
# responsibilities.
#
# Here's an incomplete list:
#   1. Verifying that the message is valid.
#   2. Verifying that the recipient emails are valid.
#   3. Stripping spaces from email addresses.
#   4. Splitting email addresses on several delimiters.
#   5. Delivering invitations.
#
# TODO: Let's improve this code by extracting a new class to handle
# responsibilities 3 and 4. Create a new class to perform these tasks, and call
# it from this one.
class SurveyInviter
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/

  def initialize(attributes = {})
    @survey = attributes[:survey]
    @message = attributes[:message] || ''
    @recipients = Recipients.new(attributes[:recipients])
    @sender = attributes[:sender]
  end

  attr_reader :message, :survey

  def valid?
    valid_message? && valid_recipients?
  end

  def deliver
    @recipients.emails.each do |email|
      invitation = Invitation.create(
        survey: @survey,
        sender: @sender,
        recipient_email: email,
        status: 'pending'
      )
      Mailer.invitation_notification(invitation, @message)
    end
  end

  def invalid_recipients
    @invalid_recipients ||= @recipients.emails.map do |email|
      unless email.match(EMAIL_REGEX)
        email
      end
    end.compact
  end

  private

  def valid_message?
    @message.present?
  end

  def valid_recipients?
    invalid_recipients.empty?
  end
end
