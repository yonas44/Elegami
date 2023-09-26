class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects, through: :project_users
  has_many :project_users, dependent: :destroy
  has_many :task_users, dependent: :destroy

  has_one_attached :image

  validates :full_name, presence: true

  def image_as_thumbnail
    image.variant(resize_to_limit: [300, 300]).processed
  end
end
