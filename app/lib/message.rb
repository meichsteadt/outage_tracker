class Message
  attr_reader :text, :timestamp

  def initialize(text, timestamp = Time.now)
    #@text:String - The content of the message
    #@timestamp:Timestamp - When the message was input

    @text = text
    @timestamp = timestamp
  end

  def formatted_timestamp
    @timestamp.strftime("%Y/%m/%d-%H:%M")
  end
end
