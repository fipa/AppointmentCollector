class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :nane
      t.string :calendar_key
      t.integer :user_id
      t.text :comments

      t.timestamps
    end
  end
end
