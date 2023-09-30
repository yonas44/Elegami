class ProjectUser < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validate :unique_user_project_association

  private

  def unique_user_project_association
    if ProjectUser.exists?(user_id: user_id, project_id: project_id)
      errors.add(:base, 'User is already associated with this project')
    end
  end
end
