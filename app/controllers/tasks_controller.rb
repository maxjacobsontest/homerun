class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy, :complete]

  # GET /tasks
  # GET /tasks.json
  def index
    @remaining_tasks = Task.search(params).remaining.by_updated_at
    @completed_tasks = Task.search(params).completed.by_completed_at
    @percent_complete = @completed_tasks.points_total.to_f / (@completed_tasks.points_total + @remaining_tasks.points_total).to_f * 100
    @total_percent_complete = Task.completed.points_total.to_f / Task.all.points_total.to_f * 100
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path, notice: 'Task was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    if @task.update(task_params)
      redirect_to root_path, notice: 'Task was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def complete
    @task.complete!
    redirect_to :back, notice: 'Great job!'
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    redirect_to :back, notice: 'Task was successfully deleted'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :points, :course_id, :category_id, :complete)
    end
end
