require 'open3'

# Function to check if a port is in use
def port_in_use?(port)
  # Using `lsof` to check if the port is in use (Linux/macOS)
  _, status = Open3.capture2("lsof -i :#{port}")
  status.success?
end

# Check if port 9292 is already in use
if port_in_use?(9292)
  puts "Port 9292 is already in use. Exiting..."
  exit 1  # Exit if the port is occupied
else
  # If port is available, configure and run Sinatra
  require './app'  # Load your Sinatra app

  # Configure Sinatra for production environment
  configure :production do
    set :logging, Logger::INFO
    set :port, 9292  # Use port 8080 or from the environment variable
    set :bind, '0.0.0.0'  # Bind to all interfaces (useful for cloud deployment)
  end

  # Run the Sinatra app
  run Sinatra::Application
end

