class User < ApplicationRecord
  has_many :favorite_locations
  has_secure_password
end
