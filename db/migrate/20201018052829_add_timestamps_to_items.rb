class AddTimestampsToItems < ActiveRecord::Migration[5.2]
  def change
    add_timestamps(:items)
  end
end
