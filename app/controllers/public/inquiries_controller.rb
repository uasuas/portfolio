class Public::InquiriesController < ApplicationController
  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      redirect_to request.referer, notice: "お問い合わせの送信が完了しました。"
    else
      flash[:alert] = "必要事項を入力してください。"
      redirect_to request.referer
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :content, :status)
  end
end
