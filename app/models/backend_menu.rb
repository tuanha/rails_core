# == Schema Information
#
# Table name: backend_menus
#
#  id            :integer          not null, primary key
#  parent_id     :integer
#  name          :string(255)
#  icon          :string(255)
#  url           :string(255)
#  highlight     :string(255)
#  display_order :integer
#  level         :integer
#  role          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class BackendMenu < ActiveRecord::Base
	validates_uniqueness_of :name
end
