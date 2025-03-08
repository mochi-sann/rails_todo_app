class Todo < ApplicationRecord
  validates :title, presence: true, length: { minimum: 1, maximum: 100 }
 attribute :done, :boolean, default: false
end
