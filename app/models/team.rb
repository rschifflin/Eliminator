# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  location   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Team < ActiveRecord::Base

def full_name
  "#{location} #{name}" 
end

end
