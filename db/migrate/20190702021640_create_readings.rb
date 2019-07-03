class CreateReadings < ActiveRecord::Migration[5.2]
  def change
    create_table :readings do |t|
      t.integer :day
      t.integer :week
      t.string :reference
      t.text :passage
    end
  end
end
