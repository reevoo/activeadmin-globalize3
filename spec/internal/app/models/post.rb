class Post < ActiveRecord::Base
  attr_accessible :title, :text
  active_admin_translates :title, :text
end
