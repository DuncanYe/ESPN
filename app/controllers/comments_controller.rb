class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_message, only: [:create, :edit, :update, :destroy]
  before_action :find_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @message.comments.create(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "留言成功"
      redirect_to message_path(@message)
    else
      flash[:alert] = "留言無法空白"
      redirect_to message_path(@message)
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] =  "留言成功更新"
      redirect_to message_path(@message)
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to message_path(@message)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end

  def find_message
    @message = Message.find(params[:message_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

end
