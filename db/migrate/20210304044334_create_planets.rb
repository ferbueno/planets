class CreatePlanets < ActiveRecord::Migration[6.1]
  def change
    create_table :planets do |t|
      t.integer :speed
      t.boolean :clockwise, default: true
      t.string :name
      t.integer :distance

      t.timestamps
    end
  end
end
