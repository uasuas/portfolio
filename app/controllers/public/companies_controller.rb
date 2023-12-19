class Public::CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def show
    begin
      @company = Company.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: '指定された会社は存在しません。'
    end
  end
end
