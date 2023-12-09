class Public::LinePlansController < ApplicationController
  def index
    @line_plans = LinePlan.all
  end

  def show
    @line_plan = LinePlan.find(params[:id])
  end
end
