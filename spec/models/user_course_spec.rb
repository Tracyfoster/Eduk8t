require "rails_helper"

RSpec.describe UserCourse, type: :model do
  describe "Validations" do
    it "has a valid factory" do
      expect(build(:user_course)).to be_valid
    end
  end

  describe "Associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:course) }
  end
end
