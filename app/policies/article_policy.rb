class ArticlePolicy < ApplicationPolicy
  def show?
    @user.rights.include?("View Article")
  end

  def new? 
    @user.rights.include?("Create Article")
  end 

  def create? 
    new? 
  end

  def edit? 
    @user.rights.include?("Edit Article") && @record.user == @user
  end 

  def update? 
    edit? 
  end
  
  def destroy?
    edit?
  end 
end