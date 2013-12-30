class Task < ActiveRecord::Base
  belongs_to :course
  belongs_to :category
  validates_presence_of :course, :category, :name, :points
  def self.remaining_points
    all.inject(0) { |sum, task| sum + task.points }
  end
end
