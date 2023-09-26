# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

    return unless user.present?
    
    can :create, Project
    can :read, Project, id: user.projects.joins(:project_users).pluck(:id)
    can %i[edit update], Project do |project|
      project_user = user.project_users.find_by(project_id: project.id)
      project_user.present? && ['admin', 'owner'].include?(project_user.role)
    end

    can :destroy, Project do |project|
      project_user = user.project_users.find_by(project_id: project.id)
      project_user.present? && ['owner'].include?(project_user.role)
    end

    # Project_user Authorization
    can %i[create destroy], ProjectUser, user_id: user.id

    # Milestones Authorization
    can :read, Milestone do |milestone|
      can?(:read, milestone.project)
    end
    
    can [:create, :destroy, :edit, :update], Milestone do |milestone|      
      project_user = user.project_users.find_by(project_id: milestone.project_id)
      project_user.present? && ['admin', 'owner'].include?(project_user.role)
    end
    
    # Tasks Authorization
    can :read, Task do |task|
      can?(:read, task.milestone)
    end
    
    can :update, Task, id: user.tasks.joins(:task_users).pluck(:id)
    can [:create, :destroy, :edit], Task do |task|
      can?(:update, task.milestone)
    end
  end
end
