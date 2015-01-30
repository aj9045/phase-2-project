class CreateEntries < ActiveRecord::Migration
  def change
     create_table :entries do |t|
      t.text :note

      t.references :first_name
      t.references :last_name
      t.references :user

      t.timestamps
    end
  end
end
