class RestaurantReview < ActiveRecord::Base
    belongs_to :user
    
    def self.valid_params?(params)
        return !params.empty?
    end
end
    