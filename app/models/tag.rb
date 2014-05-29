class Tag < ActiveRecord::Base
  belongs_to :user
  has_many :link_tags
  has_many :links, through: :link_tags
<<<<<<< HEAD
  validates :name, presence: true, length: {minimum: 2}
=======

  validates :name, presence: true, length: {minimum: 3}
>>>>>>> 48290b8528a11f42af859fd758027a4bd5243175
end
