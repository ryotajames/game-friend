class Post < ApplicationRecord
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image

  validates :image, attached: true, content_type: ['image/png', 'image/jpeg']

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  enum status: {public: 0, private: 1 }, _prefix: true

  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("post_introduction LIKE ?", "#{word}")
    elsif search == "forward_match"
      @post = Post.where("post_introduction LIKE ?", "#{word}%")
    elsif search == "backward_match"
      @post = Post.where("post_introduction LIKE ?", "%#{word}")
    elsif search == "partial_match"
      @post = Post.where("post_introduction LIKE ?", "%#{word}%")
    else
      @post = Post.all
    end
  end

end
