class SubscriptionsController < ApplicationController
  before_filter :signed_in_user

  def new
    @subscription = current_user.subscriptions.build
  end

  def create
    @subscription = current_user.subscriptions.build(subscription_params)
    if @subscription.save
      save_customer_id
      redirect_to current_user
    else
      render 'new'
    end
  end

  private

    def subscription_params
      params.require(:subscription)
            .permit(:first_name, :last_name,
                    :address_line_one, :address_line_two,
                    :zipcode, :phone_number, :plan)
    end

    def save_customer_id
      customer = Stripe::Customer.create \
        description: current_user.email,
        plan: params[:subscription][:plan],
        card: params[:stripeToken]

      current_user.update_attribute(:stripe_customer_token, customer.id)
    end
end