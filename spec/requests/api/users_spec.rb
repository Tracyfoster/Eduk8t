require "rails_helper"

RSpec.describe "/api/users", type: :request do
  let(:user) { create(:user) }
  let(:course) { create(:course) }

  let(:valid_attributes) do
    { firstname: "Tabley",
      lastname: "Jones",
      email: "tableyjones@email.com",
      expertise: "expert" }
  end

  let(:invalid_attributes) do
    { firstname: "Tabley",
      lastname: "Jones",
      email: nil,
      expertise: "expert" }
  end

  describe "GET /index" do
    it "renders a successful response" do
      User.create! valid_attributes
      get api_users_url, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      user = User.create! valid_attributes
      get api_user_url(user), as: :json
      expect(response).to be_successful
    end

    context "when user does not exist" do
      it "returns an error" do
        get "/api/users/a", as: :json
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "GET #eligible_courses" do
    it "returns user's eligible courses" do
      UserCourse.create(user: user, course: course)

      get api_user_eligible_courses_path(user), as: :json
      response_body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(response_body.first["expertise"]).to eq(user.expertise)
    end
  end

  describe "GET #my_courses" do
    it "returns user's assigned courses" do
      UserCourse.create(user: user, course: course)

      get api_user_my_courses_path(user), as: :json
      response_body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(response_body.first["expertise"]).to eq(user.expertise)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new User" do
        expect do
          post api_users_url,
               params: { user: valid_attributes }, as: :json
        end.to change(User, :count).by(1)
      end

      it "renders a JSON response with the new user" do
        post api_users_url,
             params: { user: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect do
          post api_users_url,
               params: { user: invalid_attributes }, as: :json
        end.to change(User, :count).by(0)
      end

      it "renders a JSON response with errors for the new user" do
        post api_users_url,
             params: { user: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET #assign_course" do
    context "when course is assigned" do
      it "returns http success" do
        get api_user_assign_course_path(user),
            params: { course_id: course.id }, as: :json
        expect(response).to have_http_status(:ok)
      end
    end

    context "when course is not assigned" do
      let(:another_course) { create(:course, expertise: :beginner) }

      it "returns an error message" do
        get api_user_assign_course_path(user),
            params: { course_id: another_course.id }, as: :json
            response_body = JSON.parse(response.body)

        expect(response).to have_http_status(:bad_request)
        expect(response_body["message"]).to eq("Course expertise cannot be assigned to user")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { { firstname: "Ballot" } }

      it "updates the requested user" do
        user = User.create! valid_attributes
        patch api_user_url(user),
              params: { user: new_attributes }, as: :json
        user.reload
        puts new_attributes["firstname"]
        expect(user.firstname).to eq(new_attributes[:firstname])
      end

      it "renders a JSON response with the user" do
        user = User.create! valid_attributes
        patch api_user_url(user),
              params: { user: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the user" do
        user = User.create! valid_attributes
        patch api_user_url(user),
              params: { user: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect do
        delete api_user_url(user), as: :json
      end.to change(User, :count).by(-1)
    end
  end
end
