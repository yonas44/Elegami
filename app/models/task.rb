class Task < ApplicationRecord
  belongs_to :milestone
  belongs_to :assigned_to, class_name: :User, foreign_key: 'assigned_to_id', optional: true

  validates :description, presence: true
end
