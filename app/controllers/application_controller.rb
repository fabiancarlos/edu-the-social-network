require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  include PublicActivity::StoreController

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    case resource
      when User then network_users_path
    end
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end

  def after_sign_up_path_for(resource)
    root_path
  end
end
