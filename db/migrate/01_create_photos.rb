class CreatePhotos < ActiveRecord::Migration[4.2]
  def change
    create_table :photos do |t|
      t.string :title
      t.integer :user_id
    end
  end
end
