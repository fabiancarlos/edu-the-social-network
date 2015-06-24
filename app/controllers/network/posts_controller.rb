class Network::PostsController < ApplicationController
	layout 'layout_network'
	before_filter :authenticate_user!
  
  def create
  	@post = Post.new(permitted_params)
    @post.user_id = current_user.id
    @url = network_posts_path

    respond_to do |format|
      if @post.save
        @post.create_activity :create, owner: current_user

        flash[:notice] = 'Foi publicado!'
        format.html { redirect_to network_users_path }
      else
      	flash[:alert] = 'Ocorreu algum erro ao criar sua publicação!'
        format.html { redirect_to network_users_path }
      end
    end
  end

  def destroy
  	@post = Post.where('id = ? AND user_id = ?', params[:id], current_user.id).first
    @post.destroy

    @post.create_activity :destroy, owner: current_user

    respond_to do |format|
      flash[:notice] = 'Foi apagado sua publicação!'
      format.html { redirect_to network_users_path }
      format.json { head :no_content }
    end
  end

  private

  def permitted_params
    params.require(:post).permit(:description)
  end
end
