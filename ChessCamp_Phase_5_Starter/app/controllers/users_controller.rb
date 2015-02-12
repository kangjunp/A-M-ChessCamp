class UsersController < ApplicationController

  before_action :check_login, only: [:new, :create]

  def new
    @user = User.new
  end


  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path, notice: "Thank you for signing up!"
    else
      flash[:error] = "This user could not be created."
      render "new"
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "#{@user.instructor.proper_name} is updated."
      redirect_to @user.instructor
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "Successfully removed user for #{@user.instructor.proper_name} from Chess Camp."
    redirect_to instructors_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :instructor_id, :role, :active, :password, :password_confirmation)
  end

end