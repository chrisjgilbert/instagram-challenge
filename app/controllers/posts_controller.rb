class PostsController < ApplicationController
  def index
    @posts = Post.order("created_at DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_url
    else
      render "new"
    end

    def destroy
      @post = Post.find_by(id: params[:id])
        if @post
          @post.destroy
        else
          return nil
        end
      render "index"
    end
  end

  private

  def post_params
    params.require(:post).permit(:caption, :image)
  end
end
