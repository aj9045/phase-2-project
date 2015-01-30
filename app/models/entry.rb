class Entry < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :first_name
  belongs_to :last_name
  belongs_to :user
end
