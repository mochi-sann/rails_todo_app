class Todo < ApplicationRecord
  validates :title, presence: true, length: { minimum: 1, maximum: 100 }
  validates :done, inclusion: { in: [true, false] }
end
