class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  belongs_to :link
  has_many :comments, as: :commentable
  validates :content, presence: true, length: {minimum: 10}
end
