class Milestone < ApplicationRecord
  belongs_to :project
  has_many :tasks, dependent: :destroy

  validates :title, presence: true
  validate :start_date_cannot_be_in_the_past, on: :create
  validate :due_date_after_start_date

  after_find :update_milestone_status

  def start_date_cannot_be_in_the_past
    return unless start_date.present? && start_date < Date.current

    errors.add(:start_date, "can't be in the past")
  end

  def due_date_after_start_date
    return unless start_date.present? && due_date.present? && due_date <= start_date

    errors.add(:due_date, 'must be after the start date')
  end

  private

  def update_milestone_status
    if Date.today == self.start_date && self.status != 'In_progress'
      self.update(status: 'In_progress')
    elsif Date.today > self.due_date
      tasks_count = self.tasks.where.not(status: 'Completed').count

      if tasks_count.positive?
        self.update(status: 'Behind_schedule')
      else 
        self.update(status: 'Completed')
      end
    end
  end
end
