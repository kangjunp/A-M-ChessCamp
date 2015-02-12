module ApplicationHelper

	def eligible_students_for_camp(camp)
  	Student.where("rating between ? and ?", camp.curriculum.min_rating, camp.curriculum.max_rating).active.alphabetical.all
  end

	def eligible_unregistered_students_for_camp(camp)
    eligible = eligible_students_for_camp(camp)
    already_registered = camp.students
    eligible_unregistered = eligible - already_registered
  end


end
