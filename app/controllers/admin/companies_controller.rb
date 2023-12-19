class Admin::CompaniesController < ApplicationController
  def new
    @company = Company.new
  end

  def show
    begin
      @company = Company.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: '指定された会社は存在しません。'
    end
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
    @company.destroy
    # 非同期通信でメッセージをJS書き換える内容。
    @messege = "回線企業の削除が完了しました。"
    # リクエストの形式をjsでレンダリングする為にrespond_toを使用。
    respond_to do |format|
      # jsの:review_actionを指定。
      format.js { render :company_action }
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :zip_code, :address, :telephone_number, :image)
  end
end
