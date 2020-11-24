class Review < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  has_one_attached :image
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :content, presence: true
  validates :description, presence: true
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
									message: "must be a valid image format" },
					   size:  	  { less_than: 5.megabytes,
									message: "should be less than 5MB" }
  
  def display_image
	  image.variant(resize_to_limit: [500, 500])
  end
  
  def self.search_by(search_term)
    where("LOWER(title) LIKE :search_term", search_term: "%#{search_term.downcase}%")
  end
end
