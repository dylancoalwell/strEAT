
class User < ApplicationRecord
  has_secure_password
  popular

  def self.search(search)
    where("phone LIKE ?", "%#{search}%")
  end

end
