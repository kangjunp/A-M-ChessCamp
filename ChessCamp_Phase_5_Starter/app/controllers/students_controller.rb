class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :check_login, except: [:index]

  def index
    @active_students = Student.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_students = Student.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
    authorize! :read, @student
    @student_registrations = @student.registrations.paginate(:page => params[:page]).per_page(10)
  end

  def new
    authorize! :new, @student
    @student = Student.new
  end

  def edit
    authorize! :update, @student
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to @student, notice: "#{@student.proper_name} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    authorize! :update, @student
    if @student.update(student_params)
      redirect_to @student, notice: "#{@student.proper_name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    authorize! :destroy, @student
    @student.destroy
    redirect_to students_url, notice: "#{@student.proper_name} was removed from the system."
  end

  private
    def set_student
      @student = Student.find(params[:id])
    end

    def student_params
      params.require(:student).permit(:first_name, :family_id, :last_name, :date_of_birth, :rating, :active)
    end

end
