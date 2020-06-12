class PostsController < ApplicationController

  # before_action :authenticate_user!, only: [:show, :create]

  def index
    @tag_list = PostTag.all

    if params[:post_tag_id]
      @tag = PostTag.find(params[:post_tag_id])
      @posts = @tag.posts.all
    else
      @posts = current_user.posts.all
      @post = current_user.posts.new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = current_user.comments.new
    @post_tags = @post.post_tags
  end


  def create
      @post = current_user.posts.new(post_params)
      @tag_list = params[:post][:post_tag_name].split(nil)
      if @post.save
        @post.save_tag(@tag_list)
        redirect_back(fallback_location: root_path)
      else
        redirect_back(fallback_location: root_path)
      end
  end

  def edit
    @post = current_user.posts.find(params[:id])
    @tag_list = @post.post_tags.pluck(:post_tag_name).join(',')
  end

  def update
    @post = current_user.posts.find(params[:id])
    @tag_list = params[:post][:post_tag_name].split(',')
    if @post.update(post_params)
      @post.save_tag(@tag_list)
      # redirect_back(fallback_location: root_path)
      redirect_to post_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def post_params
    # params.require(:post).permit(:title, :description, :content)
    params.require(:post).permit(:content, { post_tag_ids: [] })
  end
end
