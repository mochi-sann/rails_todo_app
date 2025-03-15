class Todo < ApplicationRecord
  validates :title, presence: true, length: { minimum: 1, maximum: 100 }
  attribute :done, :boolean, default: false
  has_one_attached :featured_image
end
