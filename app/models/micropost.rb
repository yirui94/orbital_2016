class Micropost < ActiveRecord::Base
  belongs_to :user
  has_one :user_detail, through: :user
  validates :user_id, presence: true
  validates :content, length: { maximum: 255 }
  validates :picture, presence: true
  validates :title, length: { maximum: 100 }, presence: true
  validates :medium, presence: true
  validates :price, presence: true
  validates :width, presence: true
  validates :height, presence: true

  mount_uploader :picture, PictureUploader
  validate :picture_size

  default_scope -> { order(created_at: :desc) }

  scope :by_price, -> { order(price: :desc) }

  scope :has_title, -> (title) { 
     if Rails.env.production?
      Micropost.where("title ILIKE ?", "%#{title}%")
    else
      Micropost.where("title LIKE ?", "%#{title}%")
    end
  } 

  scope :has_country, -> (country) {
    includes(:user_detail).where(user_details: { country: country })
  }

  scope :has_medium, -> (medium) {
    Micropost.where(medium: medium)
  }

  scope :has_price, -> (price) {
    Micropost.where("price <= ?", "#{price}")
  }

  scope :has_width, -> (width) {
    Micropost.where("width <= ?", "#{width}")
  }

  scope :has_width, -> (height) {
    Micropost.where("height <= ?", "#{height}")
  }

  private

   #validates size of uploaded picture
   def picture_size
   	if picture.size > 5.megabytes
   		errors.add(:picture, "should be less than 5MB")
   	end
   end
end
