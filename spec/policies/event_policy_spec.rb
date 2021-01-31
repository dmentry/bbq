require 'spec_helper'
require 'rails_helper'

RSpec.describe EventPolicy do
  let(:user) { User.new(name: "TestUser", email: "1@1.1", id: 1) }

  # объект тестирования (политика)
  subject { EventPolicy }

  context 'when user is not an owner' do
    let(:event) {Event.create(user: user, title: "TestEvent", address: "XZ", datetime: Time.now, user_id: 1)}

    # permissions :create? do
    #   it { is_expected.to permit(user, Link) }
    #   it { is_expected.not_to permit(nil, Link) }
    # end

    permissions :edit?, :update?, :destroy? do
      it { is_expected.not_to permit(user, event) }
    end
  end

  # context 'when user in an owner' do
  #   # Тестируем относительно ссылки этого юзера в этом контексте
  #   let(:link) { Link.create(url: 'goodprogrammer.ru', user: user) }

  #   permissions :show?, :edit?, :update?, :destroy? do
  #     it { is_expected.to permit(user, link) }
  #   end
  # end

  # context 'when user is an admin' do
  #   # Создаем админа и подставляем его в качестве пользователя
  #   let(:admin) { User.new(admin: true) }
  #   let(:link) { Link.create(url: 'goodprogrammer.ru', user: user) }

  #   # Админу должно быть можно делать со ссылкой все
  #   permissions :show?, :edit?, :update?, :destroy? do
  #     it { is_expected.to permit(admin, link) }
  #   end
  # end
end
