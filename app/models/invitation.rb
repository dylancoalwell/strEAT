class Invitation < ApplicationRecord
  belongs_to :sender, class_name: :User
  belongs_to :guest, class_name: :User
end
