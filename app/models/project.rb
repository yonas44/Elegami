class Project < ApplicationRecord
  has_many :users, through: :project_users
  has_many :project_users, dependent: :destroy

  validates :title, :description, presence: true
end
