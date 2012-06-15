class AddLikeCounterToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :like_counter, :int
  end
end
