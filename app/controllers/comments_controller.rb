class CommentsController < ApplicationController

  def create
    @prototype=Prototype.find(params[:prototype_id])
    @comment=@prototype.comments.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@prototype.id)
    else
      @comments=@prototype.comments.order("created_at DESC").includes(:user)
      render template: "prototypes/show"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id)
  end

end
