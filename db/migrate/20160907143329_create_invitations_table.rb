class CreateInvitationsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.float :sender_lat, {null: false, precision: 10 }
      t.float :sender_lng, {null: false, precision: 10 }
      t.float :guest_lat, {precision: 10 }
      t.float :guest_lng, {precision: 10 }
      t.integer :sender_id, {null: false}
      t.integer :guest_id

      t.timestamps(null: false)
    end
  end
end
