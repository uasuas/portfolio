class Public::LinePlansController < ApplicationController
  def index
    @line_plans = LinePlan.all
  end

  def show
    @line_plan = LinePlan.find(params[:id])
    @review = Review.new
  end

  def search
    @word = params[:content]
    @areas = Area.where("area LIKE ?", "#{@word}")
    @contents = Content.where("content LIKE ?", "#{@word}")
    @line_plans = []

    if params[:area_ids].present?
      params[:area_ids].each do |key, value|
        if value == "1"
          area_line_plans = Area.find_by(area: key).line_plans
          @line_plans = @line_plans.empty? ? area_line_plans : @line_plans & area_line_plans
        end
      end
    end
    if params[:content_ids].present?
      params[:content_ids].each do |key, value|
        if value == "1"
          content_line_plans = Content.find_by(content: key).line_plans
          @line_plans = @line_plans.empty? ? content_line_plans : @line_plans & content_line_plans
        end
      end
    end
    render "public/line_plans/search"
  end

  private

  def line_plan_params
    params.require(:line_plan).permit(:name, :monthly_fee, :introduction, :company_id)
  end
end
