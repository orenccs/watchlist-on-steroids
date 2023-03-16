class Review < ApplicationRecord
  belongs_to :list, dependent: :destroy
  validates :rating, presence: true, dependent: :destroy
end
