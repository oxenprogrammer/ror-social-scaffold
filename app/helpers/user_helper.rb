module UserHelper
  # rubocop:disable Style/GuardClause
  def friend_button(current_user, user)
    'You are friends' if friend?(current_user, user)
  end

  def friendship_button(current_user, user)
    friendship = Friendship.find_by(requestor_id: current_user.id,
                                    requestee_id: user.id) || Friendship.find_by(requestor_id: user.id,
                                                                                 requestee_id: current_user.id)
    if friendship.nil? and current_user != user
      form_for(:friendship, url: user_friendships_path(user[:id])) do |f|
        concat f.hidden_field :requestee_id, id: :friendship, value: user.id
        concat f.submit('Invite to friendship')
      end
    end
  end

  def friendship_update_button(current_user, user)
    pending_request = Friendship.find_by(requestor_id: user.id, requestee_id: current_user.id, status: 'pending')
    if current_user != user and pending_request
      concat button_to 'Accept', update_friendship_path(current_user[:id], pending_request[:id]),
                       params: { friendship: { id: pending_request[:id] } },
                       method: :patch
      button_to 'Reject', delete_friendship_path(current_user[:id], pending_request[:id]),
                params: { friendship: { id: pending_request[:id] } },
                method: :delete
    end
  end

  private

  def friend?(current_user, user)
    friendship = Friendship.find_by(requestor_id: current_user.id, requestee_id: user.id, status: 'accepted') ||
                 Friendship.find_by(requestor_id: user.id, requestee_id: current_user.id, status: 'accepted')
    true unless friendship.nil?
  end
  # rubocop:enable Style/GuardClause
end
