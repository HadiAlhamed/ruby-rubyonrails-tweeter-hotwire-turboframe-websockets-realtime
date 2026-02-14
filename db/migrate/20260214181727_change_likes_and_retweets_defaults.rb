class ChangeLikesAndRetweetsDefaults < ActiveRecord::Migration[8.1]
  def change
    change_column_default :tweets, :likes, from: nil, to: 0
    change_column_default :tweets, :retweets, from: nil, to: 0
  end
end
