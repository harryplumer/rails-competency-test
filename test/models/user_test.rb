require "test_helper"

describe User do
  let(:editor_user) { create(:user, :editor_user) }
  let(:user_user) { create(:user, :user_user) }
  let(:admin_user) { create(:user, :admin_user) }

  it "should give users the correct rights when calling rights method" do 
    value(editor_user.rights).must_include "View Article"
    value(editor_user.rights).must_include "Create Article"
    value(editor_user.rights).must_include "Edit Article"
    value(editor_user.rights).must_include "Destroy Article"
    value(user_user.rights).must_include "View Article"
  end 
  
end
