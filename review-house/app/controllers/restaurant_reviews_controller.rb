class RestaurantReviewsController < ApplicationController

    get "/reviews/index" do
        @restaurants = RestaurantReview.all
        erb :'reviews/index'
    end

    get "/reviews/new" do
        erb :'reviews/new'
    end

    post "/reviews" do
        @restaurant = RestaurantReview.create(:person_name=> params[:person_name],:title=> params[:title],:description=> params[:description], 
        :overrall_rating=> params[:overrall_rating],:noise_level=> params[:noise_level],:food_quality=> params[:food_quality],:service_qualty=> [:service_qualty],
        :is_recommended=> params[:is_recommended],:user_id=> params[:user_id])
        redirect to "/reviews/#{@restaurant.id}"
    end

    
    get "/reviews/:id/edit" do
        @restaurant = RestaurantReview.find(params[:id])
        erb :'reviews/edit'
    end

    post "reviews/:id" do
        @restaurant = RestaurantReview.find(params[:id])
        redirect "/reviews/#{@restaurant.id}"
    end


end