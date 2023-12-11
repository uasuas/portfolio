class Admin::ReviewsController < ApplicationController
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = "successfully"
    # render :destroy
  end
end
