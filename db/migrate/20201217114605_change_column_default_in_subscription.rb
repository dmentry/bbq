class ChangeColumnDefaultInSubscription < ActiveRecord::Migration[6.0]
  def change
    change_column_default :subscriptions, :user_id, nil
  end
end
