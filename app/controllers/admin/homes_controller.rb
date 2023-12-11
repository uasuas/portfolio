class Admin::HomesController < ApplicationController
  def top
    @customers = Customer.all
    @companies = Company.all
    @line_plans = LinePlan.all
    @reviews = Review.all
  end
end
