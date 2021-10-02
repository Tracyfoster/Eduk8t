require "rails_helper"

RSpec.describe User, type: :model do
  describe "Validations" do
    let(:user) { create(:user) }

    it "has a valid factory" do
      expect(build(:user)).to be_valid
    end

    it "has an invalid factory" do
      expect(build(:invalid_user)).to be_invalid
    end

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:expertise) }
  end

  describe "Associations" do
    it { is_expected.to have_many(:courses) }
  end
end
