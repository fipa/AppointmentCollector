class RenameNaneForNameInCalendars < ActiveRecord::Migration
  def change
	rename_column :calendars, :nane, :name
  end
end
