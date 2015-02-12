class Ability
  include CanCan::Ability

  def initialize(user)

      user ||= User.new
      if user.role? :admin
        can :manage, :all

      elsif user.role? :instructor
        can :update, Instructor do |instructor|  
          instructor.id == user.instructor_id
        end

        can :read, Instructor do |instructor|  
          instructor.id == user.instructor_id
        end

        can :read, Student do |this_student|
          my_students = user.instructor.camps.map{|c| c.students.map(&:id)}.flatten
          my_students.include? this_student.id
        end


        can :manage, User, :id => user.id
        
        can :read, Camp 

      else
        can :read, Camp

      end

  end
end
