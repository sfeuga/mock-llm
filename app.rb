#! /usr/bin/env ruby

# frozen_string_literal: true

require 'sinatra'
require 'faker'

post '/chat' do
  # Check if the 'query' parameter is provided
  if params['query']
  
  content_type 'text/event-stream'
  cache_control :no_cache
  connection 'keep-alive'
  
  # Generate a random number between 1 and 3 for how many paragraphs to send
  num_paragraphs = rand(1..3)
  
  stream do |out|
    num_paragraphs.times do
      # Generate a random Lorem Ipsum paragraph
      paragraph = Faker::Lorem.paragraph
    
      # Send it to the client
      out << "data: #{paragraph}\n\n"
    
      # Sleep for 3 seconds before sending the next message
      sleep 1
    end
  # After 3 paragraphs, close the connection
  end
else
  # If 'query' parameter is missing, return a bad request response
  status 400
  body 'Bad Request: Missing "query" parameter.'
  end
end

get '/health' do
  content_type :json
  status 200
  { message: 'Mock app is running smoothly!' }.to_json
end

# Run the Sinatra app
Sinatra::Application.run! if __FILE__ == $0
