class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :user_roles
  has_many :roles, through: :user_roles

  def selected_role 
    self.user_roles.find_by(is_selected: true).role
  end 

  def rights 
    Right.where(id: RoleRight.where(role: self.selected_role).pluck(:right_id)).pluck(:name)
  end 
 
end
