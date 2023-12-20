class Admin::LinePlansController < ApplicationController
  before_action :load_resource, only: [:show, :edit, :update, :destroy]
  before_action :build_resource, only: [:new, :create]

  def new
  end

  def show
  end

  def edit
  end

  def create
    # エリアとコンテンツがnilでないかを確認。
    if params[:area_ids].nil? || params[:content_ids].nil?
      flash.now[:alert] = "必要事項を入力してください。"
      render :new
      return
    end
    if @line_plan.save
      # チェックボックスから送られて来たarea_ids名の配列内容をarea_idに入れ、中間テーブルに保存する。
      params[:area_ids].each do |area_id|
        @line_plan.area_lines.create(area_id: area_id)
      end
      # チェックボックスから送られて来たcontent_ids名の配列内容をcontent_idに入れ、中間テーブルに保存する。
      params[:content_ids].each do |content_id|
        @line_plan.content_lines.create(content_id: content_id)
      end
      flash.now[:notice] = "回線プランを登録しました。"
      redirect_to admin_line_plan_path(@line_plan)
    else
      flash.now[:alert] = "必要事項を入力してください。"
      render :new
    end
  end

  def update
    # エリアとコンテンツがnilでないかを確認。
    if params[:line_plan][:area_ids][1].blank? || params[:line_plan][:content_ids][1].blank?
    # if @line_plan.area_ids.empty? || @line_plan.content_ids.empty?
      flash.now[:alert] = "必要事項を入力してください。"
      render :edit
      return
    end
    if @line_plan.update(line_plan_params)
      flash[:notice] = "回線プラン情報を更新しました。"
      redirect_to admin_line_plan_path(@line_plan)
    else
      flash.now[:alert] = "必要事項を入力してください。"
      render :edit
    end
  end

  def destroy
    @line_plan.destroy
    # 非同期通信でメッセージをJS書き換える内容。
    @messege = "回線プランを削除しました。"
    # リクエストの形式をjsでレンダリングする為にrespond_toを使用。
    respond_to do |format|
      # jsの:review_actionを指定。
      format.js { render :line_plan_action }
    end
  end

  private

  def load_resource
    @line_plan = LinePlan.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: '指定された回線プランは存在しません。'
  end

  def build_resource
    case params[:action].to_sym
    when :new
      @line_plan = LinePlan.new
    when :create
      @line_plan = LinePlan.new(line_plan_params)
    end
  end

  def line_plan_params
    params.require(:line_plan).permit(:name, :monthly_fee, :introduction, :company_id, area_ids: [], content_ids: [])
  end
end