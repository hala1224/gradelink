class Student < ApplicationRecord

  has_many :grades
  has_many :courses, through: :grades
  validates :first_name, :last_name, presence: true
  validates :first_name, :last_name, uniqueness: true


  # to see perticular student line  @student.grade
  # has_many :courses
  # has_many :users, through: :courses
#  Make a method here to create a grade and accepts a course

 scope :order_by_average, -> {left_joins(:grades).group(:id).order('avg(value) desc')}

  def self.alpha
    order(:last_name)
  end
end
