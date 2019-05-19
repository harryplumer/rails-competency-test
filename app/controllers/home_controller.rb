class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index 
    @categories = Category.all
  end 

  def change_role 
    current_user.user_roles.update_all(is_selected: false)
    UserRole.find(params[:id]).update(is_selected: true)
    redirect_to root_path
  end 

end 
