class ChangeColumnDefaultInComment < ActiveRecord::Migration[6.0]
  def change
    change_column_default :comments, :user_id, nil
  end
end
