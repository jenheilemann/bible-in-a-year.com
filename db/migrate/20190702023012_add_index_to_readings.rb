class AddIndexToReadings < ActiveRecord::Migration[5.2]
  def change
    add_index :readings, [:day, :week], unique:true
  end
end
