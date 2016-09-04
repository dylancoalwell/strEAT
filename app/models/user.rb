
class User < ApplicationRecord
  has_many :favorite_locations
  has_secure_password
  popular

  validates :email,  presence: true, format: { with: /\A.+@.+$\Z/ }, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true



  def self.search(search)
    where("phone LIKE ?", "%#{search}%")
  end

end
