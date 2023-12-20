class Public::CustomersController < ApplicationController
  before_action :load_resource, only: [:show, :update, :leave]

  def show
  end

  def update
    if @customer.update(customer_params)
      redirect_to mypage_customers_path, notice: '会員情報を更新しました。'
    else
      redirect_to mypage_customers_path, notice: '必要し事項を入力してください。'
    end
  end

  def leave
    @customer.update(is_active: false)
    reset_session
    redirect_to root_path, notice: '退会処理が完了しました。'
  end

  private

  def load_resource
    case params[:action].to_sym
    when :show
      @customer = current_customer
      @review = current_customer.reviews
    when :update
      @customer = current_customer
    when :leave
      @customer = current_customer
    end
  end

  def customer_params
    params.require(:customer).permit(:name, :email)
  end
end
