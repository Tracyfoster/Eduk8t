class User < ApplicationRecord
  validates_presence_of :email, :expertise

  enum expertise: {
    beginner: "beginner",
    advanced: "advanced",
    expert: "expert"
  }
end
