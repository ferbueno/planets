class CreateDays < ActiveRecord::Migration[6.1]
  def change
    create_table :days do |t|
      t.integer :day
      t.string :weather
      t.boolean :max_intensity, default: false

      t.timestamps
    end
    add_index :days, :weather
  end
end
