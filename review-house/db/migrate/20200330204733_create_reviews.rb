class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :person_name
      t.string :review_title
      t.string :activity_type
      t.text :rating_description
      t.integer :rating
      t.boolean :is_recommended
      t.integer :user_id
    end
  end
end
