class Admin::InquiriesController < ApplicationController
  before_action :load_resource, only: [:show, :update]
  before_action :list_resource, only: [:index]

  def index
  end

  def show
  end

  def update
    # 未確認だった場合確認済みにする。
    if @inquiry.status == false
      @inquiry.status = true
      @inquiry.save
      redirect_to admin_root_path, notice: '確認済みに更新しました。'
    else
      redirect_to admin_root_path
    end
  end

  private

  def load_resource
    @inquiry = Inquiry.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: '指定された問い合わせは存在しません。'
  end

  def list_resource
    @inquiries = Inquiry.all
  end

  def inquiry_params
    params.require(:inquiry).permit(:status)
  end
end
