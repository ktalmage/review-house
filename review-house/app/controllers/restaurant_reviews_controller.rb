class RestaurantReviewsController < ApplicationController

    get "/reviews" do
      if logged_in?
        @user = current_user
        @restaurants = RestaurantReview.all
        # @restaurants = RestaurantReview.all
        erb :'reviews/index'
      else
        redirect '/login'
      end
    end

    get "/reviews/new" do
       #check if user logged in
      #else redirect to homepage
      @error_message = params[:error]
      erb :'reviews/new'
    end

    get "/reviews/:id" do
        
      @restaurant = RestaurantReview.find(params[:id])
      erb :"reviews/show"
    end
    
    post "/reviews" do
       #check if user logged in
      #else redirect to homepage
     
        #binding.pry
       restaurant = RestaurantReview.new(params)
        restaurant.user_id = current_user.id
        if restaurant.save
        redirect "/reviews/#{restaurant.id}"
        else
          redirect "/reviews/new"
        end
    end
    
      
    
      get "/reviews/:id/edit" do
       
        @error_message = params[:error]
        @restaurant = RestaurantReview.find(params[:id])
        erb :"reviews/edit"
      end
    
      patch "/review/:id" do
       
        @restaurant = RestaurantReview.find(params[:id])
        unless RestaurantReview.valid_params?(params)
          redirect "/reviews/#{@restaurant.id}"
        end
        @restaurant.update(params)
        redirect "/reviews/#{@restaurant.id}"
      end
    
  end

