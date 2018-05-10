class MessagesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_message, only: [:show, :edit, :update, :destroy]

  def index
    @messages = Message.order(created_at: :desc)
  end

  def new
    @message = current_user.messages.create
  end

  def create
    @message = current_user.messages.create(params_message)
    if @message.save
      redirect_to @message
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @message.update(params_message)
      redirect_to @message
    else
      render :edit
    end
  end

  def destroy
    @message.destroy
    redirect_to root_path
  end

  private

  def find_message
    @message = Message.find(params[:id])
  end

  def params_message
    params.require(:message).permit(:title, :description)
  end
end
