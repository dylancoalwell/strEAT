class AddAcceptedColumnToInvitationsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :invitations, :accepted, :boolean, :default => false
  end
end
