class Course < ActiveRecord::Base
  has_many :tasks
end
