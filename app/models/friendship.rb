class Friendship < ApplicationRecord
  belongs_to :requestor, class_name: 'User', foreign_key: 'requestor_id'
  belongs_to :requestee, class_name: 'User', foreign_key: 'requestee_id'
  enum status: %i[pending accepted rejected]
  # enum status: {pending: 0, accepted: 1, rejected: 2}
end
