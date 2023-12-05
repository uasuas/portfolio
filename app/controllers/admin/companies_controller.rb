class Admin::CompaniesController < ApplicationController
  def new
    @company = Company.new
  end

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def edit
    @company = Company.find(params[:id])
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to admin_company_path(@company), notice: "回線企業の登録が完了しました。"
    else
      render :new
    end
  end

  def update
    @company = Company.find(params[:id])
    if @company.update(company_params)
      redirect_to admin_company_path(@company), notice: "回線企業情報の更新が完了しました。"
    else
      render :edit
    end
  end

  def destory
    @company = Company.find(params[:id])
    if @company.destory
      redirect_to admin_companies_path, notice: "回線企業の登録削除が完了しました。"
    else
      render :show
    end
  end

  private
  def company_params
    params.require(:company).permit(:name, :zip_code, :address, :telephone_number, :image)
  end
end
