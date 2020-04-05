require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, Proc.new { File.join(root, "../views/") }
    set :method_override, true
    enable :sessions
    set :session_secret, "FiBrIxPeRg94!"
  end

  get "/" do
    
    erb :index
    
  end

  helpers do
    
    def logged_in?
      !!current_user
    end

    def current_user
      @user ||=User.find(session[:user_id]) if session[:user_id]
      
    end
  end
end