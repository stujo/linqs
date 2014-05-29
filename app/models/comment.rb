class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  belongs_to :link
  has_many :comments, as: :commentable
<<<<<<< HEAD
  validates :comments, presence: true, length: {minimum: 2}
=======
  validates :content, presence: true, length: {minimum: 10}
>>>>>>> 48290b8528a11f42af859fd758027a4bd5243175
end
