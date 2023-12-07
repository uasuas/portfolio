class Admin::LinePlansController < ApplicationController
  def new
    @line_plan = LinePlan.new
    @areas = Area.all
  end

  def index
    @line_plans = LinePlan.all
  end

  def show
    @line_plan = LinePlan.find(params[:id])
    @areas = @line_plan.areas
  end

  def edit
    @line_plan = LinePlan.find(params[:id])
  end

  def create
    @line_plan = LinePlan.new(line_plan_params)
    if @line_plan.save
      params[:area_ids].each do |area_id|
        @line_plan.area_lines.create(area_id: area_id)
      end
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
    LinePlan.find(params[:id]).destroy
    @company = Company.find(params[:company_id])
    flash.now[:notice] = "回線プランを削除しました。"
    redirect_to company_path(params[:company_id])
  end

private

  def line_plan_params
    params.require(:line_plan).permit(:name, :monthly_fee, :introduction, :company_id)
  end
end