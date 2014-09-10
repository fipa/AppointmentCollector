class RemoveTypeFromClients < ActiveRecord::Migration
  def change
	remove_column :clients, :type
  end
end
