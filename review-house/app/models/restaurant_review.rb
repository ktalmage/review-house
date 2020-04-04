class RestaurantReview < ActiveRecord::Base
    belongs_to :user
    validates :person_name, :title, :food_type, :description, :overrall_rating, :noise_level, :food_quality, :service_quality, :is_recommended, :user_id, presence: true
    
end
    