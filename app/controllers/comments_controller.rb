class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :destroy]
  before_action :find_movie, except: [:destroy]
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.movie_id = @movie.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @movie, notice: 'Comment was successfully created.' }
        format.js   {  }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render @movie }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    Comment.find(params[:id]).destroy
    @comment_id = params[:id]
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  private 
    def comment_params
      params.require(:comment).permit(:comment)
    end

    def find_movie
      @movie = Movie.find(params[:movie_id])
    end
end
