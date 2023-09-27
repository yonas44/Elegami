class Task < ApplicationRecord
  belongs_to :milestone
  has_many :task_users, dependent: :destroy
  has_many :users, through: :task_users

  validates :description, presence: true
end
