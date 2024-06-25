class Post < ApplicationRecord
  has_one_attached :image

  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :dish, presence: true
  validates :impression, presence: true
  validates :restaurant_name, presence: true
  validates :menu, presence: true
  validates :address, presence: true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
