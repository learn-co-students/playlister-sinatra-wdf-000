class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  enable :sessions
  use Rack::Flash
  use Rack::MethodOverride
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    erb :index
  end
end