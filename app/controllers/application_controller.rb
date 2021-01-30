
class ApplicationController < ActionController::Base
  include Pundit

  def pundit_user
    UserContext.new(current_user, cookies["events_#{@event.id}_pincode"])
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Настройка для работы девайза при правке профиля юзера
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Хелпер проверяет, может ли заданный юзер редактировать заданный ивент
  helper_method :current_user_can_edit?
  helper_method :current_user_can_delete?

  # Настройка для девайза — разрешаем обновлять профиль, но обрезаем
  # параметры, связанные со сменой пароля.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:password, :password_confirmation, :current_password])
  end

  def current_user_can_edit?(model)
    user_signed_in? &&
        (model.user == current_user || (model.try(:event).present? && model.event.user == current_user))
  end

  def current_user_can_delete?(photo)
    (user_signed_in? && photo.user == current_user) || (user_signed_in? && photo.event.user == current_user)
  end

  # Обработать ошибку авторизации
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    # Перенаправляем юзера откуда пришел (или в корень сайта) с сообщением об ошибке (для секьюрности сообщение ЛУЧШЕ опустить!)
    flash[:alert] = t('pundit.not_authorized')
    redirect_to(request.referrer || root_path)
  end
end

