class AddFinishedColumnToInvitationsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :invitations, :finished, :boolean, :default => false
  end
end
