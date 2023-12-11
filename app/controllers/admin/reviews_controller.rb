class Admin::ReviewsController < ApplicationController
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash.now[:notice] = "レビューを削除しました。"
  end
end
