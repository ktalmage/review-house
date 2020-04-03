class RestaurantReviewsController < ApplicationController

    get "/reviews" do
      if logged_in?
        @user = current_user
        @restaurants = @user.restaurant_reviews
        # @restaurants = RestaurantReview.all
        erb :'reviews/index'
      else
        redirect '/login'
      end
    end

    get "/reviews/new" do
       
      @error_message = params[:error]
      erb :'reviews/new'
    end

    get "/reviews/:id" do
        
      @restaurant = RestaurantReview.find(params[:id])
      erb :"reviews/#{@restaurant.id}"
    end
    
    post "/reviews" do
       restaurants = RestaurantReview.where(title:params[:title])
       if restaurants.empty
         restaurant = RestaurantReview.create(params[:restaurant])

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
  end

