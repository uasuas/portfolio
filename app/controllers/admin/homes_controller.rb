class Admin::HomesController < ApplicationController
  def top
    @reviews = Review.all
  end
end
