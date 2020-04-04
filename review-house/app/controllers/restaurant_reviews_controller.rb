class RestaurantReviewsController < ApplicationController

    get "/reviews" do
      if logged_in?
        @user = current_user
        @restaurants = RestaurantReview.all
        erb :'reviews/index'
      else
        redirect '/login'
      end
    end

    get "/reviews/new" do
       if logged_in?
      @error_message = params[:error]
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
      @error_message = params[:error]
      @restaurant = RestaurantReview.find(params[:id])
      erb :"reviews/edit"
    end
    
    patch "/review/:id" do
      
        if @restaurant.update(params)
        redirect "/reviews/#{@restaurant.id}/edit"
        else
        
        redirect "/reviews/#{@restaurant.id}"
        end
    end
    
    delete '/reviews/:id' do
      find_review
      if @restaurant.destroy
        redirect '/reviews'
      else
        redirect "/reviews/#{@restaurant.id}"
      end
    end

    private

    def find_review
      @restaurant = RestaurantReview.find_by_id(params[:id])
    end
  end
