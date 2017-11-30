class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.string :video_src
      t.string :video_cover
      t.string :status
      t.integer :user_id
      t.integer :pv
      t.integer :pv_offset
      t.integer :likes_count
      t.string :duration

      t.timestamps null: false
    end
    add_index :videos, :user_id
  end
end
