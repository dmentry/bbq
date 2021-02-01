# Политика для описания ограничений доступа к моделям Event
class EventPolicy < ApplicationPolicy
  # можно создать событие, если есть юзер (залогинен)
  def create?
    context.user.present?
  end

  # Обновлять и удалять события могут только их создатели
  def update?
    user_is_creator?
  end

  def destroy?
    update?
  end

  def show?
    return true if record.pincode.blank?
    return true if user_is_creator?
    return true if record.pincode_valid?(context.pin)
    false
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def user_is_creator?
    context.user.present? && (record.user == context.user)
  end
end
