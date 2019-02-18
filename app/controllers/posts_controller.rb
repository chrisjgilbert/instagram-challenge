# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :find_post, only: [:show, :destroy]
  def index
    @posts = Post.order("created_at DESC")
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "Thanks for posting!"
      redirect_to posts_url
    else
      render "new"
    end
  end

  def destroy
    if @post
      @post.destroy
      flash[:success] = "Post deleted!"
      redirect_to posts_url
    else
      flash[:danger] = "Unable to delete post!"
      redirect_to posts_url
    end
  end

  private

  def post_params
    params.require(:post).permit(:caption, :image)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
