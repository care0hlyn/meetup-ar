class User < ActiveRecord::Base
	validates :name, :presence => true
	has_many :events

	before_save :capitalize

	def capitalize
		self.name = self.name.capitalize
	end
end