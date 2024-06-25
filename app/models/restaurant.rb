class Restaurant < ApplicationRecord
  belongs_to :posts
  
  validates :name, presence: true
  validates :menu, presence: true
  validates :address, presence: true
end
