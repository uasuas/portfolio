class Public::LinePlansController < ApplicationController
  def index
    @line_plans = LinePlan.all
  end

  def show
    begin
      @line_plan = LinePlan.find(params[:id])
      @review = Review.new
      @customer = current_customer
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: '指定されたラインプランは存在しません。'
    end
  end

  def search
    @word = params[:content]
    @areas = Area.where("area LIKE ?", "%#{@word}%")
    @contents = Content.where("content LIKE ?", "%#{@word}%")
    @line_plans = LinePlan.all


    if params[:area_ids].present?
      # search結果に複数のパターンがあるため、モーダルのフォームにて絞り込みをした際に他の結果を空にする処理。
      @areas = []
      @contents = []
      # 例{"area_ids"=>{"東京"=>"1", "千葉"=>"1", "埼玉"=>"1", "神奈川"=>"0", "群馬"=>"0", "栃木"=>"0", "茨城"=>"0"}
      # 上記がモーダルのフォームから送られてきた場合、"0"と"1"の内、"1"に設定されたキーが抽出され配列とする。
      # 結果["東京", "千葉", "埼玉"]となる。
      selected_area_ids = params[:area_ids].select { |_, v| v == "1" }.keys
      # selected_area_idsがany? ? で配列が空でない場合は true を返し、そうでない場合は false を返します。
      area_line_plan_ids = selected_area_ids.any? ?
      # Areaにある["東京", "千葉", "埼玉"]のものと一致したものに紐ずく、&.line_plansを取得。
      # ["東京"] ["千葉"] ["埼玉"].mapにて、Area.find_by(area: area_id)のArea内area["東京"] ["千葉"] ["埼玉"]に一致するAreaレコードを検索。
      # &.line_plansにて、それぞれのAreaに関連付けられたline_plansを、
      # &.pluck(:id) || []にて、そのidを配列として取得。
      # （中身が複数の場合はline_planの配列の中に["東京", "千葉"]であったり["東京", "千葉", "埼玉"]が入った形で配列化される）
      # その値を.reduce(:&) : nilにて、ループ処理の結果が["東京"]&["千葉"]&["埼玉"]にならないものはnilを返し、
      # ["東京", "千葉", "埼玉"]が入るline_planのidを結果としてarea_line_plan_idsに格納している。
      selected_area_ids.map { |area_id| Area.find_by(area: area_id)&.line_plans&.pluck(:id) || [] }.reduce(:&) : nil
    end
    # 上記と同じ処理のため割愛。
    if params[:content_ids].present?
      @areas = []
      @contents = []
      selected_content_ids = params[:content_ids].select { |_, v| v == "1" }.keys
      content_line_plan_ids = selected_content_ids.any? ?
      selected_content_ids.map { |content_id| Content.find_by(content: content_id)&.line_plans&.pluck(:id) || [] }.reduce(:&) : nil
    end
    # 上記の処理で得たarea_line_plan_idsとcontent_line_plan_idsの結果に応じて、
    # 絞り込み結果(@line_plans)の条件に合う全てのline_planのidを@line_plansに格納する処理。
    if area_line_plan_ids && content_line_plan_ids
      common_line_plan_ids = area_line_plan_ids & content_line_plan_ids
    elsif area_line_plan_ids
      common_line_plan_ids = area_line_plan_ids
    elsif content_line_plan_ids
      common_line_plan_ids = content_line_plan_ids
    else
      common_line_plan_ids = []
    end

    # 上記の確認後、料金の絞り込みに入り、受け取ったminまたはmaxの情報の有無によって処理を行う。
    min_search = params[:min_search]
    max_search = params[:max_search]
    # 両方ある場合。
    if max_search.present? && min_search.present?
      @line_plans = @line_plans.where("monthly_fee >= #{min_search} and monthly_fee <= #{max_search}")
    # maxのみの場合。
    elsif max_search.present?
      @line_plans = @line_plans.where("monthly_fee <= #{max_search}")
    # minのみの場合。
    elsif min_search.present?
      @line_plans = @line_plans.where("monthly_fee >= #{min_search}")
      # どれにも該当しない場合。
    else
      @line_plans = LinePlan.where(id: common_line_plan_ids)
    end
    render "public/line_plans/search"
  end

  private

  def line_plan_params
    params.require(:line_plan).permit(:name, :monthly_fee, :introduction, :company_id)
  end
end
