class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  #ユーザーが一投稿に一回しかいいねを押せないよう制限するため→ユーザーidと投稿idの組み合わせがunique
  validates :user_id, uniqueness: {scope: :post_id}
end
