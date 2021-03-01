class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.integer :user_id
      t.integer :room_id
      t.string :message

      t.timestamps
    end
  end
end
