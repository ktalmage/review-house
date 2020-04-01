require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions
    set :session_secret, "FiBrIxPeRg94!"
  end

  get "/" do
    erb :index
    
  end

  get "/registrations/signup" do
    erb :"registrations/signup"
  end

  post "/registrations/signup" do
    
    if params[:username].empty?
      redirect to '/failure'
    end

    @user = User.new(:username=> params[:username],:password=> params[:password])
    
    if @user.save
      redirect '/sessions/login'
    else
      redirect '/failure'
    end
  end

  get '/sessions/login' do
    erb :"sessions/login"
    
  end

  post "/sessions/login" do
    @user = User.find_by(:username => params[:username])
    
    if @user && @user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/"
    else
      redirect "/failure"
    end
  end

  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/"
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