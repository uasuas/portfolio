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
    render "public/line_plans/search"
  end

  private

  def line_plan_params
    params.require(:line_plan).permit(:name, :monthly_fee, :introduction, :company_id)
  end
end
