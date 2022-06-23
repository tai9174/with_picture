class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :picture
 # user_id と picture_idの組み合わせを一意性のあるものにしている
  validates :user_id, uniqueness: { scope: :picture_id }
end
