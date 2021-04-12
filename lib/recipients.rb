class Recipients
  attr_reader :emails

  def initialize(recipients)
    @emails ||= recipients.gsub(/\s+/, '').split(/[\n,;]+/)
  end
end
