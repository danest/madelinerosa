class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:show]
  before_filter :correct_user, only: [:show]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @user.subscriptions.build
  end

  def create
    @user = User.create(user_params)
    @user.first_name = "TEST"
    @user.last_name = "LAST NAME TEST"
    #@user.subscriptions.build(user_params["subscriptions_attributes"]["0"])
    puts user_params
    puts user_params["subscriptions"]
    if @user.save
      puts @user.subscriptions
      flash[:success] = "Thank you for signing up. Please finish your order."
      sign_in @user
      redirect_to new_subscription_path
    else
      puts @user.inspect
      puts @user.subscriptions.inspect
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user)
            .permit(:email, :password,
              :subscriptions_attributes => [:user_id, :first_name, :last_name,
                    :address_line_one, :address_line_two,
                    :zipcode, :phone_number, :plan])
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
