class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :articles

  def selected_role 
    self.user_roles.find_by(is_selected: true).role
  end 

  def rights
    Right.joins("INNER JOIN role_rights ON role_rights.right_id = rights.id").where("role_rights.role_id = ?", self.selected_role).pluck(:name)
  end 
 
end
