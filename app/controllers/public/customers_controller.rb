class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
    @review = current_customer.reviews
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to mypage_customers_path, notice: '会員情報を更新しました。'
    else
      redirect_to mypage_customers_path, notice: '必要し事項を入力してください。'
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email)
  end
end
