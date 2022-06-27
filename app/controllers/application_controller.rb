class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_required

  private

  def set_locale # ロケールのパラメータが設定されていない場合にはデフォルトのロケールを設定するという処理
     I18n.locale = params[:locale] || I18n.default_locale
  end

  def login_required
    redirect_to new_session_path unless current_user
  end

  def default_url_options # URLパラメータにロケール情報を渡すという処理
    { locale: I18n.locale }
  end
  
end
