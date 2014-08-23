class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :full_name
      t.string :email
      t.integer :ammount
      t.text :comments

      t.timestamps
    end
  end
end
