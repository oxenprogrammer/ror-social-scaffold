class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, foreign_key: :requestor_id, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :requestee_id, dependent: :destroy

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.accepted }
    friends_array + inverse_friendships.map { |friendship| friendship.user if friendship.accepted }
    friends_array.compact
  end

  # Users who have yet to confirm friend requests
  def pending_friends
    friendships.map { |friendship| friendship.requestee if friendship.pending }.compact
  end

  # Users who have rejected the friendship
  def rejected_friend
    friendships.map { |friendship| friendship.requestee if friendship.rejected }.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map { |friendship| friendship.requestor if friendship.pending }.compact
  end

  def friend?(user)
    friendship = Friendship.find_by(requestor_id: user.id, requestee_id: id, status: 'confirmed') ||
                 Friendship.find_by(requestor_id: id, requestee_id: user.id, status: 'confirmed')
    return true unless friendship.nil?
  end
end
