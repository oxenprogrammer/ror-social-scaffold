class Comment < ApplicationRecord
  validates :content, presence: true, length: { maximum: 200,
                                                too_long: '200 characters in comment is the maximum allowed.' }

  belongs_to :user
  belongs_to :post

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
end
