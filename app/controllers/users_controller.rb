class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:show]
  before_filter :correct_user, only: [:show]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Thank you for signing up. Please finish your order."
      sign_in @user
      redirect_to new_subscription_path
    else
      render new_user_path
    end
  end

  private
    def user_params
      params.require(:user)
            .permit(:first_name, :last_name,
                    :email, :password)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
