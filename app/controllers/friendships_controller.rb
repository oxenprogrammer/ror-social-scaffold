class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    if @friendship.nil?
      @friend_request = Friendship.new(requestor_id: current_user.id, requestee_id: friendship_params[:requestee_id])
      if @friend_request.save
        flash[:notice] = 'Friend request successfully sent'
      else
        flash[:alert] = 'Failed to send a friend request, try again'
      end
    else
      flash[:alert] = 'You can not send the request twice, wait for confirmation from the other user'
    end

    redirect_to users_path
  end

  def update
    @friend_request = Friendship.find_by(id: friendship_update_params[:id])
    if @friend_request[:status] == 'pending'
      @friend_request[:status] = 'accepted'
      if @friend_request.save
        flash[:notice] = 'Friend request accepted'
        redirect_to users_path
      else
        flash[:alert] = 'Failed to accept friend'
      end
    else
      flash[:alert] = 'Something went wrong'
    end
  end

  def destroy
    @friend_request = Friendship.find_by(id: friendship_update_params[:id])
    if @friend_request[:status] == 'pending'
      @friend_request[:status] = 'rejected'
      if @friend_request.save
        flash[:notice] = 'Friend request rejected'
        redirect_to users_path
      else
        flash[:alert] = 'Failed to reject friend'
      end
    else
      flash[:alert] = 'Something went wrong'
    end
  end

  def friendship_params
    params.require(:friendship).permit(:requestee_id)
  end

  def friendship_update_params
    params.require(:friendship).permit(:id)
  end

  private :friendship_params, :friendship_update_params
end
