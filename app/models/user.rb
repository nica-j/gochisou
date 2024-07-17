class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image

  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  
  validates :name, presence: true
  validates :introduction, presence: true
  
  # フォローしている関連付け
  has_many :active_relations, class_name: "Relation", foreign_key: "follower_id", dependent: :destroy
  
  # フォローされている関連付け
  has_many :passive_relations, class_name: "Relation", foreign_key: "followed_id", dependent: :destroy
  
  # フォローしているユーザーを取得
  has_many :followings, through: :active_relations, source: :followed
  
  # フォロワーを取得
  has_many :followers, through: :passive_relations, source: :follower
  
  # 指定したユーザーをフォローする
  def follow(user)
    active_relations.create(followed_id: user.id)
  end
  
  # 指定したユーザーのフォローを解除する
  def unfollow(user)
    active_relations.find_by(followed_id: user.id).destroy
  end
  
  #指定したユーザーをフォローしているかどうかを判定
  def following?(user)
    followings.include?(user)
  end
  
  # ゲストログイン用
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guest_user"
    end
  end
  
  def guest_user?
    email == GUEST_USER_EMAIL
  end
end
