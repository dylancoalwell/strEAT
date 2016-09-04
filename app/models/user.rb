
class User < ApplicationRecord
  has_many :favorite_locations
  has_secure_password
  popular

  def self.search(search)
    where("phone LIKE ?", "%#{search}%")
  end

end
