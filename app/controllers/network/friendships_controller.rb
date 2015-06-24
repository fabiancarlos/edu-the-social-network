class Network::FriendshipsController < ApplicationController
	layout 'layout_network'
	before_filter :authenticate_user!
  def create
  	@friendship = Friendship.new(permitted_params)
    @friendship.user_id = current_user.id
    @url = network_posts_path

    respond_to do |format|
      if @friendship.save
        # @friendship.create_activity :create, owner: current_user
        
        flash[:notice] = 'Começou a seguir!'
        format.html { redirect_to network_user_path(@friendship.friend.id) }
      else
      	flash[:alert] = 'Ocorreu algum erro!'
        format.html { redirect_to network_users_path }
      end
    end
  end

  def destroy
  	@friendship = Friendship.where('friend_id = ? AND user_id = ?', params[:id], current_user.id).first
    @friendship.destroy

    # @friendship.create_activity :destroy, owner: current_user

    respond_to do |format|
      flash[:notice] = 'Deixou de seguir!'
      format.html { redirect_to network_user_path(params[:id]) }
      format.json { head :no_content }
    end
  end

  private

  def permitted_params
    params.require(:friendship).permit(:friend_id)
  end
end
