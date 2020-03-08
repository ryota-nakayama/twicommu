class Comment < ApplicationRecord
  validates :comment, presence: true, length: { maximum: 255 }
  belongs_to :user
  belongs_to :tweet
end
