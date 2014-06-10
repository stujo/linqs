class Tag < ActiveRecord::Base
  belongs_to :user
  has_many :link_tags
  has_many :links, through: :link_tags
  validates :name, presence: true, length: { minimum: 2 }

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
