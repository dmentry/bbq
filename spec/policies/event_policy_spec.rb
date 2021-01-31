require 'rails_helper'

RSpec.describe EventPolicy do
    subject { EventPolicy }

  let(:user1) { FactoryBot.create(:user) }
  let(:user_context1) { UserContext.new(user1, '') }

  let(:user2) { FactoryBot.create(:user) }
  let(:user_context2) { UserContext.new(user2, '') }

  let(:user_with_pin) { FactoryBot.create(:user) }
  let(:user_context_with_pin) { UserContext.new(user_with_pin, '1111') }

  let(:another_user_with_pin) { FactoryBot.create(:user) }
  let(:another_user_context_with_pin) { UserContext.new(another_user_with_pin, '1111') }

  let(:user_context_anon_with_pin) { UserContext.new(nil, '1111') }

  let(:user_context_anon_without_pin) { UserContext.new(nil, '') }

  let(:event1) { FactoryBot.create(:event, user: user1) }
  let(:event2) { FactoryBot.create(:event, user: user2) }
  let(:event_with_pin) { FactoryBot.create(:event_with_pin, user: user_with_pin) }

  context "when user logged in" do
    context "create event" do
      permissions :create? do
        it "has access" do
          expect(subject).to permit(user_context1)
        end
      end
    end

    context "not user's own event" do
      permissions :show? do
        it "have access" do
          expect(subject).to permit(user_context1, event2)
        end
      end
    end

    context "user's own event" do
      permissions :edit?, :update?, :destroy? do
        it "has access" do
          expect(subject).to permit(user_context1, event1)
        end
      end
    end

    context "not user's own event" do
      permissions :edit?, :update?, :destroy? do
        it "does not have access" do
          expect(subject).not_to permit(user_context1, event2)
        end
      end
    end

    context "user's own event with pin" do
      permissions :edit?, :update?, :destroy? do
        it "has access" do
          expect(subject).to permit(user_context_with_pin, event_with_pin)
        end
      end
    end

    context "not user's own event with pin" do
      permissions :edit?, :update?, :destroy? do
        it "does not have access" do
          expect(subject).not_to permit(another_user_context_with_pin, event_with_pin)
        end
      end
    end

    context "not user's own event with pin but he has pin" do
      permissions :show? do
        it "has access" do
          expect(subject).to permit(another_user_context_with_pin, event_with_pin)
        end
      end
    end

    context "not user's own event with pin and he does not have pin" do
      permissions :show? do
        it "does not have access" do
          expect(subject).not_to permit(user_context1, event_with_pin)
        end
      end
    end
  end

  context "when user does not logged in" do
    context "see standard event" do
      permissions :show? do
        it "have access" do
          expect(subject).to permit(nil, event1)
        end
      end
    end

    context "see event with pin" do
      permissions :show? do
        it "have access" do
          expect(subject).to permit(user_context_anon_with_pin, event_with_pin)
        end
      end
    end

    context "not to see event without pin" do
      permissions :show? do
        it "does not have access" do
          expect(subject).not_to permit(user_context_anon_without_pin, event_with_pin)
        end
      end
    end

    context "not to edit event with pin" do
      permissions :edit?, :update?, :destroy? do
        it "does not have access" do
          expect(subject).not_to permit(user_context_anon_with_pin, event_with_pin)
        end
      end
    end
  end
end
