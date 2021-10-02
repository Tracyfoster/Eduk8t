require "rails_helper"

RSpec.describe Author, type: :model do
  describe "Validations" do
    let(:author) { create(:author) }

    it "has a valid factory" do
      expect(build(:author)).to be_valid
    end

    it "has an invalid factory" do
      expect(build(:invalid_author)).to be_invalid
    end

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to have_many(:courses) }
  end
end
