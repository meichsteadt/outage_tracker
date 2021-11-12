class Outage
  @@outages = []

  attr_reader :start_time, :end_time, :messages, :status, :id, :formatted_start_time, :formatted_end_time

  def initialize
    #@start_time:Timestamp - Start time of outage
    #@formatted_start_time:String - Formatted string of start time
    #@status:String - OPEN or CLOSED
    #@messages: [Message] - Messages corresponding with outage

    @start_time = Time.now
    @formatted_start_time = @start_time.strftime("%Y/%m/%d-%H:%M")
    @status = "OPEN"
    @messages = [
      Message.new(
        "Outage started",
        @start_time
      )
    ]
  end

  def add_message(message)
    #adds message to Outage
    @messages << Message.new(message)
    return message
  end

  def id=(id)
    #Saves the id of the outage
    @id = id
  end

  def self.start_outage
    #Starts an outage, unless an open outage already exists
    unless Outage.current_outage
      @outage = Outage.new
      @@outages << @outage
      @outage.id = @@outages.count
      return {message: "Outage started! 🚨 🚨 🚨"}
    else
      return {message: 'An outage already exists!'}
    end
  end

  def end_outage
    #Ends an outage, unlesss no open outage exists
    if Outage.current_outage
      @end_time = Time.now
      @formatted_end_time = @end_time.strftime("%Y/%m/%d-%H:%M")
      @status = "CLOSED"
      return {message: "Outage ended! 🥳  🎊  🍾"}
    else
      return {message: 'There is no current outage!'}
    end
  end

  def self.all
    @@outages
  end

  def self.current_outage
    return nil if @@outages.empty?
    @@outages.find {|e| e.status == "OPEN"}
  end
end
