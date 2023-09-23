class Milestone < ApplicationRecord
  belongs_to :project
  has_many :tasks, dependent: :destroy

  validates :title, presence: true
  validate :start_date_cannot_be_in_the_past
  validate :due_date_after_start_date

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.current
      errors.add(:start_date, "can't be in the past")
    end
  end

  def due_date_after_start_date
    if start_date.present? && due_date.present? && due_date <= start_date
      errors.add(:due_date, "must be after the start date")
    end
  end
end
