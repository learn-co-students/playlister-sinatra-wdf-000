class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  # set :session_secret, "my_application_secret"
  # enable :sessions
  # set :views, Proc.new { File.join(root, "../views/") }

  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end
end
