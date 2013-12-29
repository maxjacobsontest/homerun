class RenameAssociationColumns < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
      t.rename :course, :course_id
      t.rename :category, :category_id
    end
  end
end
