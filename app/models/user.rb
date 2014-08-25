class User < ActiveRecord::Base
  has_many :preferences
end
