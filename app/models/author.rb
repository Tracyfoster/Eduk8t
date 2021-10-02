class Author < ApplicationRecord
  has_many :courses, dependent: :destroy

  validates_presence_of :name
end
