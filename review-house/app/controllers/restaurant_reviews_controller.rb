class RestaurantReviewsController < ApplicationController

    get "/reviews" do
        redirect_if_not_logged_in
        @restaurants = RestaurantReview.all
        erb :'reviews/index'
    end

    post "/reviews" do
        redirect_if_not_logged_in
        unless RestaurantReview.valid_params?(params)
          redirect "/reviews/new?error=invalid restaurant"
        end
        RestaurantReview.create(params)
        redirect "/reviews"
      end
    
      get "/reviews/new" do
        redirect_if_not_logged_in
        @error_message = params[:error]
        erb :'reviews/new'
      end
    
      get "/review/:id/edit" do
        redirect_if_not_logged_in
        @error_message = params[:error]
        @restaurant = RestaurantReview.find(params[:id])
        erb :'reviews/edit'
      end
    
      post "/review/:id" do
        redirect_if_not_logged_in
        @restaurant = RestaurantReview.find(params[:id])
        unless RestaurantReview.valid_params?(params)
          redirect "/review/#{@restaurant.id}/edit?error=invalid restaurant"
        end
        @restaurant.update(params)
        redirect "/review/#{@restaurant.id}"
      end
    
      get "/review/:id" do
        redirect_if_not_logged_in
        @restaurant = RestaurantReview.find(params[:id])
        erb :'reviews/show'
      end
    
      
    end

