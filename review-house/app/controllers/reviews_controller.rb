class ReviewsController < ApplicationController

    get "/reviews" do
        redirect '/failure'
        @reviews = Review.all
        erb :'reviews/index'
    end

    get "/reviews/new" do
        redirect '/failure'
        erb :'reviews/new'
    end
end