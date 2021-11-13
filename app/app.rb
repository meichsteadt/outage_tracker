require 'sinatra'

#require the entire lib file
Dir["./app/lib/*.rb"].each {|file| require file }

#enable sessions to display flash messages
enable :sessions

# ==================== ROUTES ====================
get '/' do
  erb :index, :layout => :layout
end

post '/command' do
  # Handles the input from the user. Found at lib/command.rb
  @res = Command.handle(params[:command_text])

  # @res will be a Hash if the input is a valid command
  # @res will be a String if the input is a message
  if @res.class == Hash
    # Show the appropriate message as a flash
    session[:text] = @res[:message]
  elsif @res.class == String
    session[:text] = 'Message received'
  else
    session[:text] = nil
  end
  redirect '/'
end
