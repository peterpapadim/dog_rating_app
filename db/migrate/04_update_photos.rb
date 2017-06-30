class UpdatePhotos < ActiveRecord::Migration[4.2]

  def change
    add_column :photos, :url, :string
  end

end
