require "rails_helper"

RSpec.describe Course, type: :model do
  describe "Validations" do
    let(:course) { create(:course) }

    it "has a valid factory" do
      expect(build(:course)).to be_valid
    end

    it "has an invalid factory" do
      expect(build(:invalid_course)).to be_invalid
    end

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:expertise) }
    it { is_expected.to belong_to(:author) }
  end
end
