class AddAvatarColumnsToUsers < ActiveRecord::Migration[5.0]
  def up
    add_attachment :users, :avatars
  end

  def down
    remove_attachment :users, :avatar
  end
end
