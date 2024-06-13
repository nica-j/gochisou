class Post < ApplicationRecord
  has_one_attached :image
  
  has_one :restaurant, dependent: :destroy
  belongs_to :user
  belongs_to :genere
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
