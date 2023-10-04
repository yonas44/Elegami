class Project < ApplicationRecord
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users
  has_many :milestones, dependent: :destroy

  validates :title, :description, presence: true

  def task_statistics
    tasks = Task.joins(milestone: :project).where(projects: { id: })

    total_tasks = tasks.count
    total_completed_tasks = tasks.where(status: 'Completed').count

    { total_tasks:, total_completed_tasks: }
  end

  def completion_percentage
    tasks = task_statistics

    tasks[:total_tasks].positive? ? (tasks[:total_completed_tasks].to_f / tasks[:total_tasks] * 100).round(2) : 0
  end
end
