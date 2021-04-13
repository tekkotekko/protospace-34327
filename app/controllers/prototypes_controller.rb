class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]

  def index
    @prototypes=Prototype.all.order("created_at DESC").includes(:user)
  end

  def new
    @prototype=Prototype.new
  end

  def create
    @prototype=Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  def edit
    @prototype=Prototype.find(params[:id])
    unless current_user==@prototype.user
      redirect_to root_path
    end
  end

  def update
    @prototype=Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      render action: :show
    else
      render action: :edit
    end
  end

  def show
    @prototype=Prototype.find(params[:id])
    @comment=Comment.new
    @comments=@prototype.comments.order("created_at DESC").includes(:user)
  end

  def destroy
    prototype=Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

end
