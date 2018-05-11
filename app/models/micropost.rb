class Micropost < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :tags
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size

  def liked_by_users
    User.where(id: Action.where(target_type: "Micropost", action_type: "like", user_type: "User", target_id: self.id).pluck(:user_id))
  end

  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end