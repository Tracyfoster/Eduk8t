class Course < ApplicationRecord
  belongs_to :author
  has_many :user_courses, dependent: :nullify
  has_many :users, through: :user_courses

  validates_presence_of :title, :expertise, :expertise

  enum expertise: {
    beginner: "beginner",
    intermediate: "intermediate",
    expert: "expert"
  }
end
