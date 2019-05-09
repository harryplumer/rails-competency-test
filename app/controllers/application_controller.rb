class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :nav_bar_links
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def nav_bar_links
    @links = [{title: "Home", path: root_path}, {title: "Articles", path: articles_path}]
    if current_user&.selected_role&.name == "admin"
      @links << {title: "Admin", path: "#"} 
      @num_links = "four"
    else  
      @num_links = "three"
    end 
    if current_user.present? 
      @links << {title: "Logout", path: destroy_user_session_path}
    else 
      @links << {title: "Login", path: new_user_session_path} 
    end 
  end 
  
  private
    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password)}
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :current_password)}
    end 
end
