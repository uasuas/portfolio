class Public::ReviewsController < ApplicationController
  def create
    @review = Review.new
    @line_plan = LinePlan.find(params[:line_plan_id])
    @review = current_customer.reviews.new(review_params)
    @review.line_plan_id = @line_plan.id
    if @review.save
      # 非同期通信でメッセージをJS書き換える内容。
      @messege = "レビューを投稿しました。"
    else
      # 非同期通信でメッセージをJS書き換える内容。
      @messege = "入力項目を確認してください。"
    end
    # リクエストの形式をjsでレンダリングする為にrespond_toを使用。
    respond_to do |format|
      # jsの:review_actionを指定。
      format.js { render :review_action }
    end
  end

  def destroy
    Review.find(params[:id]).destroy
    @line_plan = LinePlan.find(params[:line_plan_id])
    @review = Review.new
    # 非同期通信でメッセージをJS書き換える内容。
    @messege = "レビューを削除しました。"
    # リクエストの形式をjsでレンダリングする為にrespond_toを使用。
    respond_to do |format|
      # jsの:review_actionを指定。
      format.js { render :review_action }
    end
  end

private

  def review_params
    params.require(:review).permit(:content, :star)
  end
end
