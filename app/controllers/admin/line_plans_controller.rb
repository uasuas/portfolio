class Admin::LinePlansController < ApplicationController
  def new
    @line_plan = LinePlan.new
  end

  def show
    @line_plan = LinePlan.find(params[:id])
  end

  def edit
    @line_plan = LinePlan.find(params[:id])
  end

  def create
    @line_plan = LinePlan.new(line_plan_params)
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
    @line_plan = LinePlan.find(params[:id])
    # エリアとコンテンツがnilでないかを確認。
    if params[:area_ids].nil? || params[:content_ids].nil?
      flash.now[:alert] = "必要事項を入力してください。"
      render :new
      return
    end
    if @line_plan.update(line_plan_params)
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

  def destroy
    @line_plan = LinePlan.find(params[:id])
    @line_plan.destroy
    @messege = "回線プランを削除しました。"
    # リクエストの形式をjsでレンダリングする為にrespond_toを使用。
    respond_to do |format|
      # jsの:review_actionを指定。
      format.js { render :line_plan_action }
    end
  end

private

  def line_plan_params
    params.require(:line_plan).permit(:name, :monthly_fee, :introduction, :company_id)
  end
end