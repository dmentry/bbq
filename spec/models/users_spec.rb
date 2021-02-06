require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.find_for_github_oauth' do
    # Создаём объект :access_token. В него записываем те данные, которые мы доставали их хеша
    let(:access_token) do
      double(
        :access_token,
        provider: 'github',
        info: double(email: 'slipin2020@mail.ru', urls: double(GitHub: 'https://api.github.com/users/dmentry'))
      )
    end

    # Ситуация: пользователь не найден
    context 'when user is not found' do
      it 'returns newly created user' do
        user = User.find_for_github_oauth(access_token)

        expect(user).to be_persisted
        expect(user.email).to eq 'slipin2020@mail.ru'
      end
    end

    # Ситуация: юзер найден по почте
    context 'when user is found by email' do
      let!(:existing_user) { FactoryBot.create(:user, email: 'slipin2020@mail.ru') }
      let!(:some_other_user) { FactoryBot.create(:user) }

      it 'returns this user' do
        expect(User.find_for_github_oauth(access_token)).to eq existing_user
      end
    end

    # Ситуация: юзер найден по провайдеру и урлу
    context 'when user is found by provider + url' do
      let!(:existing_user) do
        FactoryBot.create(:user, provider: 'github', GitHub: 'https://api.github.com/users/dmentry')
      end

      let!(:some_other_uer) { create(:user) }

      it 'returns this user' do
        expect(User.find_for_github_oauth(access_token)).to eq existing_user
      end
    end
  end
end
