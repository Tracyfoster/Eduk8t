class User < ApplicationRecord
  validates_presence_of :email, :expertise

  enum expertise: {
    beginner: "beginner",
    intermediate: "intermediate",
    expert: "expert"
  }
end
