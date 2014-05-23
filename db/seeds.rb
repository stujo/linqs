# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or create!d alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create!([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create!(name: 'Emanuel', city: cities.first)
railslink = Link.create!(:title => "Rails Guide", :url => "http://www.railsguide.com")

railslink2 = Link.create!(:title => "Stack Overflow", :url => "http://www.stackoverflow.com")
railslink3 = Link.create!(:title => "PostGres", :url => "http://www.postgres.com")

tag = Tag.create!(:name => "ruby")

Tag.create!(:name => "rails")
Tag.create!(:name => "arrays")
Tag.create!(:name => "hashes")
Tag.create!(:name => "sinatra")
Tag.create!(:name => "rspec")
Tag.create!(:name => "javascript")

commenta = railslink.comments.create!(:content => "Shaq is awesome")
commentb = railslink2.comments.create!(:content => "Taylor likes to be the boss")
commentc = railslink2.comments.create!(:content => "The team is becoming awesome")
commentd = commenta.comments.create!(:content => "Rahul needs to calm down")