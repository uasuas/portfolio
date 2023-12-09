class Public::ReviewsController < ApplicationController
  def create
    @review = Review.new
    @line_plan = LinePlan.find(params[:line_plan_id])
    review = current_customer.reviews.new(review_params)
    review.line_plan_id = @line_plan.id
    if review.save
      flash.now[:notice] = "コメントを投稿しました。"
      redirect_to line_plan_path(params[:line_plan_id])
    else
      flash.now[:alert] = "コメントを入力してください。"
      redirect_to line_plan_path(params[:line_plan_id])
    end
  end

  def destroy
    Review.find(params[:id]).destroy
    @line_plan = LinePlan.find(params[:line_plan_id])
    @review = Review.new
    flash.now[:notice] = "コメントを削除しました。"
    redirect_to line_plan_path(params[:line_plan_id])
  end

private

  def review_params
    params.require(:review).permit(:content, :star)
  end
end
