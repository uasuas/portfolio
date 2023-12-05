class Public::HomesController < ApplicationController
  def top
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

  def about
    areas = params[:area]
    contents = params[:contents]
    prices = params[:price]
    @plan = (areas.to_s + contents.to_s + prices.to_s).presence
    @plan_details = PlanDetail.all
  end
end
