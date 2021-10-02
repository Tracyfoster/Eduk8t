require "rails_helper"

RSpec.describe "/api/courses", type: :request do
  let(:author) { create(:author) }
  let(:valid_attributes) do
    { title: "Crytocurrency, The Hard Parts",
      description: "Learn deeper truths about cryto",
      expertise: "expert",
      industry: "Finance",
      author_id: author.id }
  end

  let(:invalid_attributes) do
    { title: nil,
      description: "Insurance Foundations",
      expertise: "beginner",
      industry: "Insurance",
      author_id: author.id }
  end

  describe "GET /index" do
    it "renders a successful response" do
      Course.create! valid_attributes
      get api_courses_url, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      course = Course.create! valid_attributes
      get api_course_url(course), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Course" do
        expect do
          post api_courses_url,
               params: { course: valid_attributes }, as: :json
        end.to change(Course, :count).by(1)
      end

      it "renders a JSON response with the new course" do
        post api_courses_url,
             params: { course: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Course" do
        expect do
          post api_courses_url,
               params: { course: invalid_attributes }, as: :json
        end.to change(Course, :count).by(0)
      end

      it "renders a JSON response with errors for the new course" do
        post api_courses_url,
             params: { course: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        { expertise: "intermediate" }
      end

      it "updates the requested course" do
        course = Course.create! valid_attributes
        patch api_course_url(course),
              params: { course: new_attributes }, as: :json
        course.reload
        expect(course.expertise).to eq("intermediate")
      end

      it "renders a JSON response with the course" do
        course = Course.create! valid_attributes
        patch api_course_url(course),
              params: { course: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the course" do
        course = Course.create! valid_attributes
        patch api_course_url(course),
              params: { course: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested course" do
      course = Course.create! valid_attributes
      expect do
        delete api_course_url(course), as: :json
      end.to change(Course, :count).by(-1)
    end
  end
end
