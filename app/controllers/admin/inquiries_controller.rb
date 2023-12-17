class Admin::InquiriesController < ApplicationController
  def index
    @inquiries = Inquiry.all
  end

  def show
    @inquiry = Inquiry.find(params[:id])
  end

  def update
    @inquiry = Inquiry.find(params[:id])
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

  def inquiry_params
    params.require(:inquiry).permit(:status)
  end
end
