class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category

  def author 
    "#{self.user.first_name} #{self.user.last_name}"
  end 

  def show_buttons(user)
    self.user == user
  end 

  def written_at 
    self.created_at.strftime("%l:%M %p %-m/%-d/%Y")
  end

end 