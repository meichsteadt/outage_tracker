class Command
  def self.handle(command)
    # Takes a string input and if it is a valid command calls the appropriate method
    # otherwise if there is a current outage, creates a message from the user input.

    #checks to see if command is a reserved keyword
    _cmnd = self.commands[command.to_sym]
    if _cmnd
      # if yes, run method
      return _cmnd.call
    elsif Outage.current_outage
      #else if there is a current outage, save as message
      return Outage.current_outage.add_message(command)
    else
      #if not current outage and not valid command, send error message
      return {message: 'Not a valid command'}
    end
  end

  def self.commands
    #defines valid commmands
    {
      'start_outage': lambda {Outage.start_outage},
      'end_outage': lambda {Outage.current_outage.end_outage}
    }
  end
end
