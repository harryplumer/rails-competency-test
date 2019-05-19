class AdminController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action :get_roles, only: [:new, :edit, :update, :create]

  def index
    @users = User.all
    authorize @users
    @show_create = current_user&.rights&.include?("Create User")
  end 

  def new
    @user = User.new
    @action = "create"
    authorize @user
  end 

  def create
    @user = User.new(user_params)
    authorize @user
    if @user.save
      form_roles
      @user.user_roles.first.update(is_selected: true) if @user.user_roles.where(is_selected: true).blank?
      flash[:success] = "User has been created!"
      redirect_to admin_index_path
    else
      flash[:alert] = "There was an error creating this user. Please try again."
      render :new
    end
  end 

  def edit
    authorize @user
    @action = "update"
    @user_role_ids = @user.user_roles.pluck(:role_id)
  end 

  def update 
    authorize @user
    if @user.update(user_params)
      form_roles
      non_active = Role.all.pluck(:id) - @form_active 
      UserRole.where(user_id: @user.id, role_id: non_active)&.destroy_all
      flash[:success] = "User has been updated!"
      redirect_to admin_index_path
    else
      flash[:alert] = "There was an error updating this article. Please try again."
      render :edit
    end
  end 

  private 
  def set_user 
    @user = User.find(params[:id])
  end 

  def get_roles 
    @roles = Role.all.order(:name)
  end 

  def form_roles
    @form_active = @roles.select{|r| params.dig("user_role_#{r.id}") == "true"}.pluck(:id)
    @form_active.each do |role_id|
      u = UserRole.find_or_initialize_by(user_id: @user.id, role_id: role_id)
      u.is_selected = false if u.id.nil?
      u.save 
    end 
  end 

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email)
  end 

end 