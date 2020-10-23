class AddTimestampsToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_timestamps(:customers)
  end
end
