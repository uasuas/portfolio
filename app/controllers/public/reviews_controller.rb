class Public::ReviewsController < ApplicationController
  before_action :load_resource, only: [:create, :destroy]

  def create
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
    @review.destroy
    # 非同期通信でメッセージをJS書き換える内容。
    @messege = "レビューを削除しました。"
    # リクエストの形式をjsでレンダリングする為にrespond_toを使用。
    respond_to do |format|
      # jsの:review_actionを指定。
      format.js { render :review_action }
    end

  end

  private

  def load_resource
    case params[:action].to_sym
    when :create
      begin
        @line_plan = LinePlan.find(params[:line_plan_id])
        @review = current_customer.reviews.new(review_params)
      rescue ActiveRecord::RecordNotFound
        record_not_found
      end
    when :destroy
      begin
        @review = Review.find(params[:id])
        @line_plan = LinePlan.find(params[:line_plan_id])
      rescue ActiveRecord::RecordNotFound
        record_not_found
      end
    end
  end

  def record_not_found
    redirect_to root_path, alert: '指定されたデータは存在しません。'
  end

  def review_params
    params.require(:review).permit(:content, :star)
  end
end
