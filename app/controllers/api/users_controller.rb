class Api::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy eligible_courses
                                    assign_course my_courses]

  # GET /api/users
  def index
    @users = User.all

    render json: @users
  end

  # GET /api/users/1
  def show
    render json: @user
  end

  # GET /api/users/:user_id/eligible_courses
  def eligible_courses
    @courses = @user.eligible_courses
    render json: @courses
  end

  # GET /api/users/:user_id/my_courses
  def my_courses
    @courses = @user.courses

    render json: @courses
  end

  # POST /api/users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # POST /api/users/:user_id/assign_course
  def assign_course
    course = Course.find(params[:course_id])
    if course.expertise == @user.expertise
      UserCourse.create!({ user: @user, course: course })
      head :ok
    else
      render json: { message: "Course expertise cannot be assigned to user" },
             status: :bad_request
    end
  end

  # PATCH /api/users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/users/1
  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = if params[:id]
              User.find(params[:id])
            elsif params[:user_id]
              User.find(params[:user_id])
            end
  end

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :expertise)
  end
end
