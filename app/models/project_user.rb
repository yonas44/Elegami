class ProjectUser < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validate :unique_user_project_association, on: :create

  private

  def unique_user_project_association
    return unless ProjectUser.exists?(user_id:, project_id:)

    errors.add(:base, 'User is already associated with this project')
  end
end
