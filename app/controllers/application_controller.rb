class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :nav_bar_links
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def nav_bar_links
    @links = [{title: "Home", path: root_path, controller: "home", sublinks: []}, 
      {title: "Articles", path: articles_path, controller: "articles", sublinks: []}]
    if current_user&.selected_role&.name == "admin"
      @links << {title: "Admin", path: admin_index_path, controller: "admin", sublinks: []} 
    end 
    if current_user.present? && current_user.user_roles.count > 1
      sublinks = current_user.user_roles.map do |user_role| 
        {title: "#{user_role.role.name.titleize} #{user_role.is_selected ? '(Active)' : ''}", 
        path: change_role_path(user_role.id)}
      end     
      @links << {title: "Change Role", path: "#", controller: nil, sublinks: sublinks }
    end 
    if current_user.present? 
      @links << {title: "Logout", path: destroy_user_session_path}
    else 
      @links << {title: "Login", path: new_user_session_path} 
    end
    @num_links = NumbersInWords.in_words(@links.count)
  end 
  
  private
    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path
    end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password)}
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :current_password)}
    end 
end
