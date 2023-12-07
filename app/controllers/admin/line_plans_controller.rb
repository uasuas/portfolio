class Admin::LinePlansController < ApplicationController
  def new
    @line_plan = LinePlan.new
    
    @areas = {
      "東京" => "１",
      "千葉" => "２",
      "埼玉" => "３",
      "神奈川" => "４",
      "群馬" => "５",
      "栃木" => "６",
      "茨城" => "７",
      "山梨" => "８"
    }
    @contents = {
      "テレビ回線" => "１",
      "インターネット回線" => "２",
      "電話回線" => "４",
      "テレビ回線・インターネット回線" => "３",
      "テレビ回線・電話回線回線" => "５",
      "インターネット回線・電話回線" => "６",
      "テレビ回線・インターネット回線・電話回線" => "７"
    }
    @prices = {
      "1,000円〜2,000円" => "１",
      "2,001円〜3,000円" => "２",
      "3,001円〜4,000円" => "３",
      "4,001円〜5,000円" => "４",
      "5,001円〜6,000円" => "５",
      "6,000円~" => "6",
    }
  end

  def index
    @line_plans = LinePlan.all
  end

  def show
    @line_plan = LinePlan.find(params[:id])
  end

  def edit
    @line_plan = LinePlan.find(params[:id])
  end

  def create
    @line_plan = LinePlan.new(line_plan_params)
    if @line_plan.save
      flash.now[:notice] = "回線プランを登録しました。"
      redirect_to admin_companies_path
    else
      flash.now[:alert] = "必要事項を入力してください。"
    end
  end

  def destroy
    LinePlan.find(params[:id]).destroy
    @company = Company.find(params[:company_id])
    flash.now[:notice] = "回線プランを削除しました。"
    redirect_to company_path(params[:company_id])
  end

private

  def line_plan_params
    params.require(:line_plan).permit(:name, :monthly_fee, :introduction, :company_id)
  end
end