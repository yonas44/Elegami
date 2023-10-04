class Milestone < ApplicationRecord
  belongs_to :project
  has_many :tasks, dependent: :destroy

  validates :title, presence: true
  validates :start_date, presence: true, on: :create
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
    if milestone_starts_today? || milestone_due_date_extended?
      update(status: 'In_progress')
    elsif milestone_past_due_date?
      tasks_count = tasks.where.not(status: 'Completed').count

      if tasks_count.positive?
        update(status: 'Behind_schedule')
      else
        update(status: 'Completed')
      end
    end
  end

  def milestone_starts_today?
    Date.today == start_date && status != 'In_progress'
  end

  def milestone_due_date_extended?
    Time.now <= due_date && status == 'Behind_schedule'
  end

  def milestone_past_due_date?
    Time.now > due_date
  end
end
