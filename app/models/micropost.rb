class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, length: { maximum: 140 }
  validates :picture, presence: true
  mount_uploader :picture, PictureUploader
  default_scope -> { order(created_at: :desc) }
  validate :picture_size

  private

   #validates size of uploaded picture
   def picture_size
   	if picture.size > 5.megabytes
   		errors.add(:picture, "should be less than 5MB")
   	end
   end
end
