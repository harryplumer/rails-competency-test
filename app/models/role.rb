class Role < ApplicationRecord
  has_many :role_rights
  has_many :rights, through: :role_rights
end 
