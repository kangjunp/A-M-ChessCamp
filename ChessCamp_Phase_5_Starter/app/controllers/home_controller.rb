class HomeController < ApplicationController
  def index
		@upcoming_camps = Camp.upcoming.active.chronological.paginate(:page => params[:page]).per_page(5)
		if logged_in?&&current_user.role?(:instructor)
			@instructor = Instructor.find(current_user.instructor_id)
			@user_upcoming_camps = @instructor.camps.upcoming.chronological
      @past_camps = @instructor.camps.past.chronological
		end

    if logged_in?&&current_user.role?(:admin)
      @instructor = Instructor.find(current_user.instructor_id)
      @instructor_camps = Instructor.active.alphabetical.paginate(:page => params[:page]).per_page(10)
      @camps = Camp.upcoming.active.chronological.paginate(:page => params[:page]).per_page(10)
      @registration = Registration.new
    end
  end

  def about
  end

  def contact
  end

  def privacy
  end

  
end
