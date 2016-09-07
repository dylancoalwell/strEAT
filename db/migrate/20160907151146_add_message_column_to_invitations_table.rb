class AddMessageColumnToInvitationsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :invitations, :message, :text
  end
end
