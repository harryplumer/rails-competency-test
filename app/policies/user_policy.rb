class UserPolicy < ApplicationPolicy
  def index?
    @user.rights.include?("View Users")
  end

  def new? 
    @user.rights.include?("Create User")
  end 

  def create? 
    new? 
  end

  def edit? 
    @user.rights.include?("Edit User")
  end 

  def update? 
    edit? 
  end
  
end