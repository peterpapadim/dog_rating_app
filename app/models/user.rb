class User < ActiveRecord::Base
  has_many :photos
  has_many :ratings, through: :photos
end
