class Category < ApplicationRecord
  has_many :articles

  def home_articles
    self.articles.order(created_at: :desc).limit(3)
  end 
end 