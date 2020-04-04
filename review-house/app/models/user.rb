class User < ActiveRecord::Base
    has_many :restaurant_reviews
    has_secure_password
    validates :username, :name, :password, presence: true
end