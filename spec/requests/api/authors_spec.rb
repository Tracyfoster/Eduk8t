require "rails_helper"

RSpec.describe "/api/authors", type: :request do
  let(:valid_attributes) do
    { name: Faker::Name.name,
      title: "VP Growth and Development",
      company_name: Faker::Company.name,
      bio: Faker::Lorem.paragraph }
  end

  let(:invalid_attributes) do
    { name: nil,
      title: "VP Growth and Development",
      company_name: Faker::Company.name,
      bio: Faker::Lorem.paragraph }
  end

  describe "GET /index" do
    it "renders a successful response" do
      Author.create! valid_attributes
      get api_authors_url, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      author = Author.create! valid_attributes
      get api_author_url(author), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Author" do
        expect do
          post api_authors_url,
               params: { author: valid_attributes }, as: :json
        end.to change(Author, :count).by(1)
      end

      it "renders a JSON response with the new author" do
        post api_authors_url,
             params: { author: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Author" do
        expect do
          post api_authors_url,
               params: { author: invalid_attributes }, as: :json
        end.to change(Author, :count).by(0)
      end

      it "renders a JSON response with errors for the new author" do
        post api_authors_url,
             params: { author: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        { name: "John Paul" }
      end

      it "updates the requested author" do
        author = Author.create! valid_attributes
        patch api_author_url(author),
              params: { author: new_attributes }, as: :json
        author.reload
        expect(author.name).to eq("John Paul")
      end

      it "renders a JSON response with the author" do
        author = Author.create! valid_attributes
        patch api_author_url(author),
              params: { author: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the author" do
        author = Author.create! valid_attributes
        patch api_author_url(author),
              params: { author: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested author" do
      author = Author.create! valid_attributes
      expect do
        delete api_author_url(author), as: :json
      end.to change(Author, :count).by(-1)
    end
  end
end
