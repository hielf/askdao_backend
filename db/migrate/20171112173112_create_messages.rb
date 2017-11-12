class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.string :content
      t.string :status

      t.timestamps null: false
    end
    add_index :messages, :user_id
  end
end
