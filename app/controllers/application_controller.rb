class ApplicationController < ActionController::Base
  # before_action :basic_auth  # Basic 認証のフィルターをコメントアウトまたは削除

  before_action :configure_permitted_parameters, if: :devise_controller?  # Devise で使用する許可されたパラメーターを設定

  protected

  # Devise で許可されるパラメーターを指定
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :occupation, :position])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :occupation, :position])
  end
end