class Project < ApplicationRecord
  has_many :users, through: :project_users
  has_many :project_users, dependent: :destroy
  has_many :milestones, dependent: :destroy

  validates :title, :description, presence: true

  def total_tasks
    Task.joins(milestone: :project).where(projects: { id: }).count
  end

  def total_completed_tasks
    Task.joins(milestone: :project)
      .where(projects: { id: })
      .where(status: 'Completed')
      .count
  end

  def completion_percentage
    total_tasks.positive? ? (total_completed_tasks.to_f / total_tasks * 100).round(2) : 0
  end
end
