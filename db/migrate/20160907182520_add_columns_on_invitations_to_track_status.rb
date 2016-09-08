class AddColumnsOnInvitationsToTrackStatus < ActiveRecord::Migration[5.0]
  def change
    add_column :invitations, :active, :boolean, :default => false
  end
end
