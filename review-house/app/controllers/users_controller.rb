
class UsersController < ApplicationController
    get "/users/new" do
        erb :"users/new"
        
      end
    
    post "/users/new" do
    
        if params[:username].empty?
          redirect to '/failure'
        end
    
        @user = User.new(:username=> params[:username],:password=> params[:password], :name=> params[:name])
      
        if @user.save
          
          redirect '/users/login'
        else
          redirect '/failure'
        end
      end
    
    get '/users/login' do
        erb :"users/login"
        
      end
    
    post "/users/login" do
        @user = User.find_by(:username => params[:username])
        
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect "/reviews"
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
end