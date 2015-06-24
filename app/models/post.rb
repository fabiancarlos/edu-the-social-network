class Post < ActiveRecord::Base
	include PublicActivity::Common
  # tracked except: :update, owner: ->(controller, model) { controller && controller.current_user }
  belongs_to :user
  validates_presence_of :description, :user_id
end
