class PostsController < ApplicationController
  before_action :authenticate, except: [:index, :show]
  before_action :set_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.paginate(page: params[:page])
  end

  def show
    @post = Post.find_by(slug: params[:id])
  end

  def new
    @post = @user.posts.new
  end

  def edit
  end

  def create
    @post = @user.posts.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Article crééé.'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Article mis à jour'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Article supprimé.'
  end

  private
    def set_post
      @post = @user.posts.find_by!(slug: params[:id])
    rescue
      @post = @user.posts.find_by(id: params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :image, comments_attributes: [:title])
    end
end
