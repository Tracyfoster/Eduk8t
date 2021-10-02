class Api::AuthorsController < ApplicationController
  before_action :set_author, only: %i[show update destroy]

  # GET /api/authors
  def index
    @authors = Author.all

    render json: @authors
  end

  # GET /api/authors/1
  def show
    render json: @author
  end

  # POST /api/authors
  def create
    @author = Author.new(author_params)

    if @author.save
      render json: @author, status: :created
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/authors/1
  def update
    if @author.update(author_params)
      render json: @author
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/authors/1
  def destroy
    @author.destroy
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author)
          .permit(:name, :title, :company_name, :bio)
  end
end
