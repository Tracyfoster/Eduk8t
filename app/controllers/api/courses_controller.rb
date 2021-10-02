class Api::CoursesController < ApplicationController
  before_action :set_course, only: %i[show update destroy]

  # GET /api/courses
  def index
    @courses = Course.all

    render json: @courses
  end

  # GET /api/courses/1
  def show
    render json: @course
  end

  # POST /api/courses
  def create
    @course = Course.new(course_params)

    if @course.save
      render json: @course, status: :created
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  # PATCH /api/courses/1
  def update
    if @course.update(course_params)
      render json: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/courses/1
  def destroy
    @course.destroy
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title,
                                   :description,
                                   :expertise,
                                   :industry)
  end
end
