require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  describe "admin user" do
    setup do
      @user = create(:user, :admin_user)
      sign_in @user
    end

    test "should get index" do
      get admin_index_url
      assert_response :success
    end

    test "should get new" do
      get new_admin_url
      assert_response :success
    end

    test "should create user" do
      assert_difference('User.count') do
        role = "user_role_#{Role.first.id}".to_sym
        post admin_index_url, params: { user: {email: "thisisatest@test.com", first_name: "Test", last_name: "Test", password: "TestTest123!", password_confirmation: "TestTest123!"}, "#{role}": "true"}
      end

      assert_redirected_to admin_index_url
    end

    test "should get edit" do
      get edit_admin_url(@user)
      assert_response :success
    end

    test "should update user" do
      role = "user_role_#{@user.user_roles.first.role.id}".to_sym 
      patch admin_url(@user), params: { user: {email: "thisisatest@test.com", first_name: "Test", last_name: "McDonald"}, "#{role}": "true"}
      assert_redirected_to admin_index_url
    end
  end

  describe "non-admin user" do 
    setup do
      @user = create(:user, :user_user)
      sign_in @user
    end
    
    test "should redirect index" do
      get admin_index_url
      assert_redirected_to root_path
    end

    test "should redirect on new" do
      get new_admin_url
      assert_redirected_to root_path
    end

    test "should not create user and redirect" do
      assert_difference('User.count', 0) do
        role = "user_role_#{Role.first.id}".to_sym
        post admin_index_url, params: { user: {email: "thisisatest@test.com", first_name: "Test", last_name: "Test", password: "TestTest123!", password_confirmation: "TestTest123!"}, "#{role}": "true"}
      end
      assert_redirected_to root_path
    end

    test "should not get edit and redirect" do
      get edit_admin_url(@user)
      assert_redirected_to root_path
    end

    test "should not user article" do
      role = "user_role_#{@user.user_roles.first.role.id}".to_sym 
      patch admin_url(@user), params: { user: {email: "thisisatest@test.com", first_name: "Test", last_name: "McDonald"}, "#{role}": "true"}      
      assert_redirected_to root_path
    end

  end
end
