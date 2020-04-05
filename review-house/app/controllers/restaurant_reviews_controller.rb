class RestaurantReviewsController < ApplicationController

    get "/reviews" do
      if logged_in?
        # @user = current_user
        @restaurants = RestaurantReview.all
        erb :'reviews/index'
      else
        redirect '/login'
      end
    end

    get "/reviews/new" do
       if logged_in?
      # @error_message = params[:error]
      erb :'reviews/new'
      else
        redirect '/'
      end
    end

    post "/reviews" do
       if logged_in?
        restaurant = RestaurantReview.new(params)
        restaurant.user_id = current_user.id
        if restaurant.save
        redirect "/reviews/#{restaurant.id}"
        else
          redirect "/reviews/new"
        end
      else
        redirect '/'
      end
    end
    
    get "/reviews/:id" do
     
      if logged_in?
      @restaurant = RestaurantReview.find(params[:id])
      erb :"reviews/show"
     else
      redirect '/login'
      end
    end
    
    get "/reviews/:id/edit" do
     if !logged_in?
      redirect to '/login'
     end
     find_review
     if @restaurant.user_id = current_user.id
      erb :'/reviews/edit'
     else
      redirect to '/login'
     end
    end
    
    patch "/reviews/:id" do
      find_review
      if params[:id].empty?
        redirect "/reviews/#{@restaurant.id}/edit"
      else
        @restaurant = RestaurantReview.find_by_id(params[:id])
        @restaurant.person_name = params[:person_name]
        @restaurant.title = params[:title]
        @restaurant.description = params[:description]
        @restaurant.overrall_rating = params[:overrall_rating]
        @restaurant.noise_level = params[:noise_level]
        @restaurant.food_quality = params[:food_quality]
        @restaurant.service_quality = params[:service_quality]
        @restaurant.is_recommended = params[:is_recommended]
        @restaurant.save
        redirect "/reviews/#{@restaurant.id}"
      end
    end
    
    delete '/reviews/:id/delete' do
      if logged_in?
        find_review
        @restaurant.delete
        redirect to '/reviews'
      else
        redirect to "/"
      end
     end
  
    private

    def find_review
      @restaurant = RestaurantReview.find_by_id(params[:id])
    end
end
