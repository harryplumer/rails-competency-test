require "test_helper"

describe Article do
  let(:user) { create(:user, :editor_user) }
  let(:category) { create(:category )}
  let(:article) { create(:article, user: user, category: category) }

  it "must be written by correct author" do
    value(article.author).must_equal "#{user.first_name} #{user.last_name}"
  end

  it "should show buttons true if created by this user" do 
    value(article.show_buttons(user)).must_equal true
  end 

  it "should show buttons false if created by another user" do 
    user_2 = create(:user, :editor_user)
    value(article.show_buttons(user_2)).must_equal false
  end
  
  it "should format the date correctly" do 
    article.update(created_at: "2019-01-01")
    value(article.written_at).must_equal "12:00 AM 1/1/2019"
  end 

end
