class Course < ApplicationRecord
  validates_presence_of :title, :expertise, :expertise

  enum expertise: {
    beginner: "beginner",
    intermediate: "intermediate",
    expert: "expert"
  }
end
