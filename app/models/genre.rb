class Genre < ApplicationRecord
  has_many :genres, dependent: :destroy
end
