class MakeBodyNotNull < ActiveRecord::Migration[8.1]
  def change
    change_column_null :tweets, :body, false
  end
end
