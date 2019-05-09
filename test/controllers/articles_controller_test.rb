require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  describe "editor user" do
    setup do
      @user = create(:user, :editor_user)
      sign_in @user
      @category = create(:category)
      @article = create(:article, user: @user, category: @category)

    end

    test "should get index" do
      get articles_url
      assert_response :success
    end

    test "should get new" do
      get new_article_url
      assert_response :success
    end

    test "should create article" do
      assert_difference('Article.count') do
        post articles_url, params: { article: {title: "Test", content: "Test", category_id: @category.id, user: @user} }
      end

      assert_redirected_to article_url(Article.last)
    end

    test "should show article" do
      get article_url(@article)
      assert_response :success
    end

    test "should get edit" do
      get edit_article_url(@article)
      assert_response :success
    end

    test "should update article" do
      patch article_url(@article), params: { article: {title: "Test", content: "Test", category: @category, user: @user}}
      assert_redirected_to article_url(@article)
    end

    test "should destroy article" do
      assert_difference('Article.count', -1) do
        delete article_url(@article)
      end

      assert_redirected_to articles_url
    end
  end

  describe "standard user" do 
    setup do
      @user = create(:user, :user_user)
      sign_in @user
      @category = create(:category)
      @article = create(:article, user: @user, category: @category)
    end
    
    test "should get index" do
      get articles_url
      assert_response :success
    end

    test "should redirect on new" do
      get new_article_url
      assert_redirected_to root_path
    end

    test "should not create article and redirect" do
      assert_difference('Article.count', 0) do
        post articles_url, params: { article: {title: "Test", content: "Test", category_id: @category.id, user: @user} }
      end
      assert_redirected_to root_path
    end

    test "should show article" do
      get article_url(@article)
      assert_response :success
    end

    test "should not get edit and redirect" do
      get edit_article_url(@article)
      assert_redirected_to root_path
    end

    test "should not update article" do
      patch article_url(@article), params: { article: {title: "Test", content: "Test", category: @category, user: @user}}
      assert_redirected_to root_path
    end

    test "should not destroy article" do
      assert_difference('Article.count', 0) do
        delete article_url(@article)
      end
      assert_redirected_to root_path
    end
  end
end
