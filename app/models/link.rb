class Link < ActiveRecord::Base
  has_many :link_tags
  has_many :tags, through: :link_tags
  has_many :comments, as: :commentable
  belongs_to :user
  accepts_nested_attributes_for :link_tags

  validates :title, presence: true, length: { minimum: 2 }
  validates :url, presence: true, length: { minimum: 9 }

  def self.keywords
    doc = Pismo::Document.new(self)
  end

  def self.search_for(query)
    where('url LIKE :query OR title LIKE :query', query: "%#{query}%")
    # how do we return what is in the tags as well
  end

  # Pagination
  # self.per_page = 20
end
