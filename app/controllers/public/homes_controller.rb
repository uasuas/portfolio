class Public::HomesController < ApplicationController
  def top
    @companies = Company.all.sample(5)
  end

  def about
  end
end
