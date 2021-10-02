class User < ApplicationRecord
  has_many :user_courses, dependent: :nullify
  has_many :courses, through: :user_courses
  validates_presence_of :email, :expertise

  enum expertise: {
    beginner: "beginner",
    intermediate: "intermediate",
    expert: "expert"
  }

  def eligible_courses
    Course.where(expertise: expertise)
  end
end
