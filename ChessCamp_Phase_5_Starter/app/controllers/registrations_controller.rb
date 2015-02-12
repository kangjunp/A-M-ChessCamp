class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @registration = Registration.new
    @registration.student_id = params[:student_id]
  end

  def edit
  end

  def create
    @registration = Registration.new(registration_params)
    if @registration.save
      redirect_to camp_path(@registration.camp_id), notice: "Successfully created registration for #{@registration.student.proper_name}."
    else
      render action: 'new'
    end
  end

  def update
    if @registration.update(registration_params)
      redirect_to @registration, notice: "Successfully updated registration for #{@registration.student.proper_name}."
    else
      render action: 'edit'
    end
  end

  def destroy
    @registration.destroy
    redirect_to camps_url, notice: "Successfully destroyed registration for #{@registration.student.proper_name}."
  end

  private
    def set_registration
      @registration = Registration.find(params[:id])
    end

    def registration_params
      params.require(:registration).permit(:camp_id, :student_id, :payment_status, :points_earned)
    end
end