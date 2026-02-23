class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment
  include ActionView::RecordIdentifier
  def show
  end

  def edit
  end
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.turbo_stream { }
        format.html { redirect_to @comment.commentable, notice: "Comment updated!" }
      else
      format.turbo_stream { render turbo_stream: turbo_stream.replace(
                @comment,
                partial: "comments/form",
                locals: { comment: @comment }
              )}
        format.html { render :edit, status: :unprocessable_entity }

      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.turbo_stream {  }
      format.html { redirect_to @comment.commentable }
    end
  end



  private
  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
