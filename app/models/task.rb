class Task < ActiveRecord::Base

  ULTIMATE_DUE_DATE = Chronic.parse "March 1 2014"

  belongs_to :course
  belongs_to :category

  validates_presence_of :course, :category, :name, :points

  scope :completed, -> { where(complete: true) }
  scope :remaining, -> { where(complete: false) }
  scope :completed_today, -> { where(completed_on: Time.now.beginning_of_day..Time.now.end_of_day) }
  scope :by_completed_at, -> { order(completed_on: :desc) }
  scope :by_updated_at, -> { order(updated_at: :desc) }
  #scope :by_point_value, -> { order(points: :desc) }
  #scope :by_point_value_asc, -> { order(:points) }

  def self.search(params)
    response = Task.all
    if params[:id]
      return Task.where(:id => params[:id])
    end
    if params[:course]
      response = response.joins(:course).where(:courses => { :name => params[:course] })
    end
    if params[:category]
      response = response.joins(:category).where(:categories => { :name => params[:category] })
    end
    if params[:points]
      response = response.where(:points => params[:points])
    end
    if params[:sort]
      direction, sorter = params[:sort][0] == "-" ? [:desc, params[:sort][1..-1]] : [:asc, params[:sort]]
      case sorter
      when "course"
        response = response.joins(:course).order("courses.name #{direction}")
      when "category"
        response = response.joins(:category).order("categories.name #{direction}")
      when "name", "points"
        response = response.order(sorter => direction)
      end
    end
    response
  end

  def self.points_total
    all.inject(0) { |sum, task| sum + task.points }
  end

  def self.last_completed
    Task.completed.by_completed_at.first
  end

  def self.any_completed?
    all.where(complete: true).count > 0
  end

  def self.all_completed?
    all.where(complete: true).count == all.count
  end

  def self.days_until_due_date
    ((Time.now - ULTIMATE_DUE_DATE) / 60 / 60 / 24).abs.floor
  end

  def self.points_today
    completed_today.points_total
  end

  def self.points_per_day
    (remaining.points_total.to_f / days_until_due_date).floor
  end

  def self.good_day?
    points_today >= points_per_day
  end

  def complete=(val)
    if [true, "1"].include? val
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
