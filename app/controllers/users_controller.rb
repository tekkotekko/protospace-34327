class UsersController < ApplicationController
  def show
    @user=User.find(params[:id])
    @prototypes=@user.prototypes.order("created_at DESC").includes(:user)
  end

end
