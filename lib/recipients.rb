class Recipients
  def initialize(recipients)
    @emails ||= recipients.gsub(/\s+/, '').split(/[\n,;]+/)
  end

  def emails
    @emails || ''
  end
end
