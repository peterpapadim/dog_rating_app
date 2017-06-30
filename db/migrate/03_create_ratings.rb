class CreateRatings < ActiveRecord::Migration[4.2]
  def change
    create_table :ratings do |t|
      t.integer :score
      t.integer :user_id
      t.integer :photo_id
    end
  end
end
