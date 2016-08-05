class ApplicationController < Sinatra::Base
  enable :sessions
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }
  use Rack::Flash
  use Rack::MethodOverride
  
  get '/' do
    erb :index
  end
end
