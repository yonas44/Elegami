class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :create, Project
    can :read, Project, id: user.projects.joins(:project_users).pluck(:id)
    can %i[edit update], Project do |project|
      project_user = user.project_users.find_by(project_id: project.id)
      project_user.present? && %w[admin owner].include?(project_user.role)
    end

    can :destroy, Project do |project|
      project_user = user.project_users.find_by(project_id: project.id)
      project_user.present? && ['owner'].include?(project_user.role)
    end

    # Project_user Authorization
    can %i[read create update destroy], ProjectUser do |project_user|
      can?(:destroy, project_user.project)
    end

    # Milestones Authorization
    can :read, Milestone do |milestone|
      can?(:read, milestone.project)
    end

    can [:create, :destroy, :edit, :update], Milestone do |milestone|
      can?(:update, milestone.project)
    end

    # Tasks Authorization
    can :read, Task do |task|
      can?(:read, task.milestone)
    end

    can :update, Task do |task|
      task_ids_with_access = user.tasks.joins(:task_users).pluck(:id)
      task.id.in?(task_ids_with_access) || can?(:update, task.milestone)
    end

    cannot :edit, Task do |task|
      true unless can?(:update, task.milestone)
    end

    can [:create, :destroy], Task do |task|
      can?(:update, task.milestone)
    end
  end
end
