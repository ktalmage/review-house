class UsersController < ApplicationController
    
  get '/users/:id' do
    redirect_if_not_logged_in
      if !logged_in?
        redirect '/login'
      end
    
    @user = User.find_by(id: params[:id])
    
    if !@user.nil? && @user == current_user
      erb :'users/show'
    else
      redirect '/signup'
    end
  end

    get '/signup' do
      if !session[:id]
        erb :'users/signup'
      else
        redirect to '/reviews/new'
      end
    end

    post '/signup' do
      if params[:username] == "" || params[:password] == ""
        redirect to '/signup'
      else
        @user = User.create(:username => params[:username], :password => params[:password], :name=> params[:name])
        session[:user_id] = @user.id
        redirect '/reviews/new'
      end
    end

    get '/login' do
      if !session[:user_id]
        erb :'users/login'
      else
        redirect '/reviews'
      end
    end

    post '/login' do
      @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/reviews/show"
    else
      redirect to '/'
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end