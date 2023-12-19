class Admin::ReviewsController < ApplicationController
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    # 非同期通信でメッセージをJS書き換える内容。
    @messege = "レビューを削除しました。"
    respond_to do |format|
      # jsの:review_actionを指定。
      format.js { render :destroy }
    end
  end
end
