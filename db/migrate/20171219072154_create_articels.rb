class CreateArticels < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :summary
      t.string :author
      t.string :url
      t.integer :user_id
      t.string :status

      t.timestamps null: false
    end
    add_index :articles, :user_id
  end
end
