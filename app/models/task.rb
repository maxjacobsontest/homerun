class Task < ActiveRecord::Base
  belongs_to :course
  belongs_to :category
  validates_presence_of :course, :category, :name, :points
end
