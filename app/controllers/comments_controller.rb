class CommentsController < ApplicationController

  def create
    @message = Message.find(parmas[:message_id])
    @comment = @message.comments.create(params_comment)
    @comment.user = current_user
    if @comment.save
      redirect_to message_path(@message)
    else
      render :create
    end
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end

  private

  def params_comment
    params.require(:comment).permit(:content, :user_id)
  end

  def find_comment
    
  end

  def find_message
    
  end
end
