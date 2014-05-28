class Tag < ActiveRecord::Base
  belongs_to :user
  has_many :link_tags
  has_many :links, through: :link_tags

   def self.search(search)
  	search_condition = "%" + search + "%"
  	find(:all, :conditions => ['name like ? ', search_condition])
  end
end
