class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.email}",
      amount: amt
    }
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )


    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: amt,
      description: 'Blocipedia Premium Membership-#{current_user.email}',
      currency: 'usd'
    )

    flash[:succes] = "Thanks for upgrading, you are now a Premium Member!"
    current_user.role = :premium
    current_user.save!

    redirect_to wikis_path

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def destroy
      current_user.standard!
      flash[:notice] = "\"#{current_user.email}\" was downgraded to standard successfully.\nAll associated Wiki's have been marked as PUBLIC."


      wikis = current_user.wikis
      wikis.each do |wiki|
        if wiki.private
          wiki.private = false
          wiki.save!
        end

      redirect_to new_charge_path

    end
  end

  private
  def amt
    10_00
  end

  # closes class
end
