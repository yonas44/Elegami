class Task < ApplicationRecord
  belongs_to :project
  belongs_to :assigned_to, class_name: :User, foreign_key: 'assigned_to_id', optional: true
  belongs_to :created_by, class_name: :User, foreign_key: 'created_by_id'
end
