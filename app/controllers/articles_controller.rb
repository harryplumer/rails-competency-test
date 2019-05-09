class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index]

  def index 
    @articles = Article.all.order(created_at: :desc)
    @show_create = current_user&.rights&.include?("Create Article")
  end 

  def show
    authorize @article
  end 

  def new 
    @article = Article.new
    authorize @article
  end 

  def create 
    @article = current_user.articles.new(article_params)
    authorize @article
    if @article.save
      flash[:success] = "Article has been created!"
      redirect_to articles_path
    else
      flash[:alert] = "There was an error publishing this article. Please try again."
      render partial: "form"
    end
  end 

  def edit
    authorize @article
  end 

  def update
    authorize @article
    if @article.update(article_params)
      flash[:success] = "Article has been updated!"
      redirect_to article_path(@article)
    else
      flash[:alert] = "There was an error publishing this article. Please try again."
      render partial: "form"
    end
  end 

  def destroy
    authorize @article
    @article.destroy
    flash[:success] = "Article has been destroyed!"
    redirect_to articles_path
  end 

  private 
  def set_article
    @article = Article.find(params[:id])
  end 

  def article_params
    params.require(:article).permit(:title, :content, :category_id)
  end 

end 
