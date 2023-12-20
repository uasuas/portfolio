class Admin::CustomersController < ApplicationController
  before_action :load_resource, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer), notice: '会員情報を更新しました。'
    else
      flash.now[:notice] = '必要し事項を入力してください。'
      render :edit
    end
  end

  private

  def load_resource
    @customer = Customer.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: '指定された会社は存在しません。'
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :is_active)
  end
end
