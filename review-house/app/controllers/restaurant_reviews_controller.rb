class RestaurantReviewsController < ApplicationController

    get "/reviews/:id" do
        # redirect_if_not_logged_in
        @restaurants = RestaurantReview.all
        erb :'reviews/index'
       
    end

    post "/reviews" do
        # redirect_if_not_logged_in
        @restaurants = RestaurantReview.all
        unless @restaurants.valid_params?(params)
          redirect "/failure"
        end
        @restaurants.create(params)
        redirect "/reviews/#{@restaurants.id}"
      end
    
      get "/reviews/new" do
        # redirect_if_not_logged_in
        @error_message = params[:error]
        erb :'reviews/new'
      end
    
      get "/reviews/:id/edit" do
        # redirect_if_not_logged_in
        @error_message = params[:error]
        @restaurant = RestaurantReview.find(params[:id])
        erb :"reviews/#{@restaurant.id}/edit"
      end
    
      post "/review/:id" do
        # redirect_if_not_logged_in
        @restaurant = RestaurantReview.find(params[:id])
        unless RestaurantReview.valid_params?(params)
          redirect "/reviews/#{@restaurant.id}"
        end
        @restaurant.update(params)
        redirect "/reviews/#{@restaurant.id}"
      end
    
      get "/review/:id" do
        # redirect_if_not_logged_in
        @restaurant = RestaurantReview.find(params[:id])
        erb :"reviews/#{@restaurant.id}"
      end
    
      
    end

