class ChangeFullNameForFirstAndLastNamea < ActiveRecord::Migration
  def change
	rename_column :clients, :full_name, :first_name
	add_column :clients, :last_name, :string
  end
end
