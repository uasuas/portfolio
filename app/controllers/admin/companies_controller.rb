class Admin::CompaniesController < ApplicationController
  def new
    @company = Company.new
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
      flash.now[:alert] = "必要事項を入力してください。"
      render :new
    end
  end

  def update
    @company = Company.find(params[:id])
    if @company.update(company_params)
      redirect_to admin_company_path(@company), notice: "回線企業情報の更新が完了しました。"
    else
      flash.now[:alert] = "必要事項を入力してください。"
      render :edit
    end
  end

  def destroy
    @company = Company.find(params[:id])
    if @company.destroy
      flash.now[:notice] = "回線企業の削除が完了しました。"
      render :company_action
    else
      render :show
    end
  end

  private
  
  def company_params
    params.require(:company).permit(:name, :zip_code, :address, :telephone_number, :image)
  end
end
