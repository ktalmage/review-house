class CreateRestaurantReviews < ActiveRecord::Migration
  def change
    create_table :restaurant_reviews do |t|
      t.string :person_name
      t.string :review_title
      t.string :food_type
      t.text :rating_description
      t.integer :overrall_rating
      t.integer :noise_level
      t.string  :food_quality
      t.string :service_quality
      t.boolean :is_recommended 
      t.integer :user_id
    end
  end
end
