class GradesController < ApplicationController


  def new
    @students = Student.all
    @course = Course.find_by_id(params[:course_id])
    @grade = @course.grades.build #has_many & grade belongs_to course
  end

  def create
    @grade = Grade.new(grade_params)
    @course = Course.find_by_id(params[:course_id])
    if @grade.save
        redirect_to grade_path(@grade)
    else
        @students = Student.all
        render :new
      end
    end


#  Showing individual grade

    def show
     set_grade
     @course = Course.find_by_id(@grade.course_id)
    end

    def index
      #nested & a valid id
        @students = Student.all
        if @course = Course.find_by_id(params[:course_id])
           #nested ? scope method
            @grades = @course.grades.order(:student_id)
        else
            #it's not nested
            @grades = Grade.all
        end
    end


    def edit
      set_grade
      @course = Course.find_by_id(params[:id])
      @student = Student.find_by_id(@grade.student_id)
    end

    def update
      set_grade
      @grade.update(grade_params)
      @grade.save
      redirect_to grade_path(@grade)
    end

    def destroy
      set_grade
      @grade.destroy
      redirect_to grades_path
    end

    private

    def set_grade
        @grade = Grade.find_by(id: params[:id])
        if !@grade
          redirect_to grades_path
        end
      end


    def grade_params
        params.require(:grade).permit(:value, :comment, :student_id, :course_id, student_attributes: [:first_name, :last_name])
    end

end
