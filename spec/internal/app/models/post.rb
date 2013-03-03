class Post < ActiveRecord::Base
  attr_accessible :title, :text
  translates :title, :text
end
