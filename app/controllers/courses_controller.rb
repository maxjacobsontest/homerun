class CoursesController < ApplicationController
  before_action :set_course, only: [:edit, :update, :destroy]

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to root_path, notice: 'Course was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    if @course.update(course_params)
      redirect_to root_path, notice: 'Course was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    redirect_to root_path, notice: 'Course was successfully deleted'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name)
    end
end
