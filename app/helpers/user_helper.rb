module UserHelper
  def friendship_button(current_user, user)
    @friendship = Friendship.find_by(requestor_id: current_user.id,
                                     requestee_id: user.id) || Friendship.find_by(requestor_id: user.id,
                                                                                  requestee_id: current_user.id)
    if @friendship.nil? and current_user != user
      form_for(:friendship, url: user_friendships_path(user[:id])) do |f|
        concat f.hidden_field :requestee_id, id: :friendship, value: user.id
        concat f.submit('Invite to friendship')
      end
    end
  end
end
