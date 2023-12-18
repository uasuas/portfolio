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
    @areas = Area.where("area LIKE ?", "%#{@word}%")
    @contents = Content.where("content LIKE ?", "%#{@word}%")
    @line_plans = []
    
    if params[:area_ids].present?
      @areas = []
      @contents = []
      selected_area_ids = params[:area_ids].select { |_, v| v == "1" }.keys
      area_line_plan_ids = selected_area_ids.any? ? 
      selected_area_ids.map { |area_id| Area.find_by(area: area_id)&.line_plans&.pluck(:id) || [] }.reduce(:&) : nil
    end
    
    if params[:content_ids].present?
      @areas = []
      @contents = []
      selected_content_ids = params[:content_ids].select { |_, v| v == "1" }.keys
     content_line_plan_ids = selected_content_ids.any? ? 
      selected_content_ids.map { |content_id| Content.find_by(content: content_id)&.line_plans&.pluck(:id) || [] }.reduce(:&) : nil
    end
    
    if area_line_plan_ids && content_line_plan_ids
      common_line_plan_ids = area_line_plan_ids & content_line_plan_ids
    elsif area_line_plan_ids
      common_line_plan_ids = area_line_plan_ids
    elsif content_line_plan_ids
      common_line_plan_ids = content_line_plan_ids
    else
      common_line_plan_ids = []
    end

    @line_plans = LinePlan.where(id: common_line_plan_ids)
    
    render "public/line_plans/search"
  end

  private

  def line_plan_params
    params.require(:line_plan).permit(:name, :monthly_fee, :introduction, :company_id)
  end
end
