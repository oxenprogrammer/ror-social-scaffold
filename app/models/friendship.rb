class Friendship < ApplicationRecord
  belongs_to :requestor, class_name: 'User', foreign_key: 'requestor_id'
  belongs_to :requestee, class_name: 'User', foreign_key: 'requestee_id'
  enum status: %i[pending accepted rejected]

  validates_presence_of :requestor, :requestee

  def self.requestee(current_user)
    where(requestor_id: current_user, status: 'accepted').pluck(:requestee_id)
  end

  def self.requestor(current_user)
    where(requestee_id: current_user, status: 'accepted').pluck(:requestor_id)
  end

  def self.friend?(current_user, user)
    friendship = find_by(requestor_id: current_user.id, requestee_id: user.id, status: 'accepted') ||
                 find_by(requestor_id: user.id, requestee_id: current_user.id, status: 'accepted')
    true unless friendship.nil?
  end

  def self.both_sided_friendship(current_user, user)
    find_by(requestor_id: current_user.id,
            requestee_id: user.id) || Friendship.find_by(requestor_id: user.id,
                                                         requestee_id: current_user.id)
  end
end
