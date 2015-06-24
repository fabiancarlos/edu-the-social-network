class Network::UsersController < ApplicationController
	layout 'layout_network'
	before_filter :authenticate_user!

  def index
  	@activities = PublicActivity::Activity.order("created_at DESC").where(owner_id: current_user.friend_ids << [current_user.id], owner_type: "User")
  end

  def show
  	@user = User.find(params[:id])
  	@activities = PublicActivity::Activity.order("created_at DESC").where(owner_id: @user.id, owner_type: "User")
  end
end
