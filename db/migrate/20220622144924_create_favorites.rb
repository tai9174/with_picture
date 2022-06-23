class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true
      t.references :picture, foreign_key: true

      t.timestamps
    end
    # favoritesテーブルに置いてuser_idとpicture_idの組み合わせを一意性のあるものしている。
    add_index  :favorites, [:user_id, :picture_id], unique: true
  end
end
