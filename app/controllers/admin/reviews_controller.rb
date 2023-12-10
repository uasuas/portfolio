class Admin::ReviewsController < ApplicationController
  def destroy
    review = Review.find(params[:id])
    review.destroy
    flash[:notice] = "successfully"
    redirect_to admin_root_path
  end
end
