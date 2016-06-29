class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, length: { maximum: 140 }
  validates :picture, presence: true
  mount_uploader :picture, PictureUploader
  default_scope -> { order(created_at: :desc) }
  validate :picture_size

  def Micropost.search(string)
    if Rails.env.production?
      Micropost.where("content ILIKE ?", "%#{string}%")
    else
      Micropost.where("content LIKE ?", "%#{string}%")
    end
  end

  private

   #validates size of uploaded picture
   def picture_size
   	if picture.size > 5.megabytes
   		errors.add(:picture, "should be less than 5MB")
   	end
   end
end
