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
      "テレビ" => "１",
      "ネット" => "２",
      "電話" => "４",
      "テレビ＋ネット" => "３",
      "テレビ＋電話" => "５",
      "ネット＋電話" => "６",
      "テレビ＋ネット＋電話" => "７"
    }
    @prices = {
      "１０００〜２０００" => "１",
      "２００１〜３０００" => "２",
      "３００１〜４０００" => "３",
      "４００１〜５０００" => "４",
      "５００１〜６０００" => "５"
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
