require './app'  # Load your Sinatra app

# Configure Sinatra for production environment
configure :production do
  set :logging, Logger::INFO
end

# Run the Sinatra app
run Sinatra::Application

