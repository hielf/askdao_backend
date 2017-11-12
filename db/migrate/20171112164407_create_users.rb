class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :open_id
      t.string :mobile
      t.string :email
      t.string :wx_user_name
      t.string :nick_name

      t.timestamps null: false
    end
    add_index :users, :open_id
  end
end
