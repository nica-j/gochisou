class Genre < ApplicationRecord
  has_many :genres, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
end
