
class User < ApplicationRecord
  has_secure_password
  popular

  validates :first_name, :last_name, :email, :phone, :password, presence: true
  validates :email, uniqueness: true

  def self.search(search)
    where("phone LIKE ?", "%#{search}%")
  end

end
