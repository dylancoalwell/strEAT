
class User < ApplicationRecord
  has_secure_password
  popular

  # this is for uploading an avatar
  has_attached_file :avatar,
    styles: { medium: "300x300>",
    thumb: "100x100>" },
    default_url: "http://sadat-e-amrohacanada.org/main/wp-content/uploads/2014/11/profile-42914_640-300x278-150x150.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  validates :email,  presence: true, format: { with: /\A.+@.+$\Z/ }, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true


  def self.search(search)
    where("phone LIKE ?", "%#{search}%")
  end

end
