require "test_helper"

describe Category do
  let(:category) { create(:category) }
  let(:user) { create(:user) }

  before(:each) do 
    @top_3 = []
    3.times.each do |i| 
      @top_3 << create(:article, category: category, created_at: Time.now, user: user)
    end 
    2.times.each do |i|
      create(:article, category: category, created_at: Time.now-1.day, user: user)
    end 
  end 

  it "should give users the correct rights when calling rights method" do 
    top_3 = Article.where(category: category).order(created_at: :desc).limit(3)
    value(category.home_articles).must_equal @top_3
  end 
  
end
