class AddCompleteToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :complete, :boolean, :default => false
    add_column :tasks, :completed_on, :datetime
  end
end
