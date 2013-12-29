class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :points
      t.integer :course
      t.integer :category

      t.timestamps
    end
  end
end
