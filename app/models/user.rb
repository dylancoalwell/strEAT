
class User < ApplicationRecord
  has_secure_password
  popular

  validates :first_name, :last_name, :email, :phone, :password, presence: true
  validates :email, uniqueness: true

  # this is for uploading an avatar
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  def self.search(search)
    where("phone LIKE ?", "%#{search}%")
  end

end
