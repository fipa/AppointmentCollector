class RemoveUserIdAndAddCalendarIdFromClients < ActiveRecord::Migration
  def change
	remove_column :clients, :user_id
	add_column :clients, :calendar_id, :integer
  end
end
