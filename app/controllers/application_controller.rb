class ApplicationController < ActionController::Base
  before_action :authenticate_customer!, except: [:top, :about]
  # deviseのコントローラーが実行されている場合にのみメソッドを呼び出す。
  before_action :configure_permitted_parameters, if: :devise_controller?
  # 管理者としてログインしていない場合アクセス制限をするが、その前にadmin_area?の戻り値を確認してtrueなら実行する。
  before_action :authenticate_admin!, if: :admin_area?
  # 存在しないURLの入力だった場合、rootに戻しアラートを表示。
  def redirect_to_root
    redirect_to root_path, alert: '入力されたURLは存在しない為、URLをご確認ください。'
  end

  private

  def after_sign_in_path_for(resource)
    # 管理者のログイン時。送られて来た値が、is_a?の（）内にあるAdminのものであるかを確認している。
    if resource.is_a?(Admin)
      admin_root_path
    # ユーザーのログイン時。送られて来た値が、is_a?の（）内にあるCustomerのものであるかを確認している。
    elsif resource.is_a?(Customer)
      mypage_customers_path
    # 予期しない値の時。
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    # 管理者のログアウト時。
    if resource.is_a?(Admin)
      admin_root_path
    # ユーザーのログアウト時。
    elsif resource.is_a?(Customer)
      root_path
    # 予期しない値の時。
    else
      root_path
    end
  end
   # sign_inページ以外のadminが含まれるurlにリクエストする場合trueを返す。
  def admin_area?
    request.fullpath.include?("/admin") && !request.fullpath.include?("/admin/sign_in")
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :is_active])
  end

end
