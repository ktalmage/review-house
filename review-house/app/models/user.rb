class User < ActiveRecord::Base
    has_many :restaurant_reviews
    has_secure_password
    validates :username, :name, :password, presence: true
    validates_uniqueness_of :username
end