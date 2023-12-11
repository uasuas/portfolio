class Admin::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer), notice: '会員情報を更新しました。'
    else
      flash.now[:notice] = '必要し事項を入力してください。'
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :is_active)
  end
end
