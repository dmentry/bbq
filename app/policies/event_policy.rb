# Политика для описания ограничений доступа к моделям Event
class EventPolicy < ApplicationPolicy
  # можно создать событие, если есть юзер (залогинен)
  def create?
    user.present?
  end

  # Обновлять и удалять события могут только их создатели
  def update?
    user_is_creator?
  end

  def destroy?
    update?
  end

  # показывать события всем, если нет пин-кода
  # иначе - только тем, кто его ввел или у кого он есть в куках
  def show?
    return true if record.pincode.blank?
    return true if user_is_creator?
    return true if record.pincode_valid?(pin)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def user_is_creator?
    user.present? && (record.user == user)
  end

  # def check_pin(user, pin, record)
  #   return true if record.pincode.blank?
  #   return true if user_is_creator?(record)
  #   return true if record.pincode_valid?(pin)
  # end
end
