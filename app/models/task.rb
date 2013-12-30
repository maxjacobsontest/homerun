class Task < ActiveRecord::Base

  belongs_to :course
  belongs_to :category

  validates_presence_of :course, :category, :name, :points

  scope :completed, -> { where(complete: true) }
  scope :remaining, -> { where(complete: false) }

  def self.search(params)
    response = Task.all
    if params[:course]
      response = response.joins(:course).where(:courses => { :name => params[:course] })
    end
    if params[:category]
      response = response.joins(:category).where(:categories => { :name => params[:category] })
    end
    response
  end

  def self.points_total
    all.inject(0) { |sum, task| sum + task.points }
  end

  def self.all_completed?
    all.all? { |t| t.complete == true }
  end

  def complete=(val)
    if val == "1"
      self.completed_on = Time.now
    else
      self.completed_on = nil
    end
    super(val)
  end

  def complete!
    self.complete = true
    self.save
  end

  def uncomplete!
    self.complete = false
    self.save
  end

end
