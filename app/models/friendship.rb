class Friendship < ApplicationRecord
  belongs_to :requestor, class_name: 'User', foreign_key: 'requestor_id'
  belongs_to :requestee, class_name: 'User', foreign_key: 'requestee_id'
  enum status: %i[pending accepted rejected]

  validates_presence_of :requestor, :requestee
end
