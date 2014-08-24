class Array
	def sort_by_date
    self.sort { |a,b| a.start <=> b.start }
  end
end

class Event < ActiveRecord::Base
	validates :description, :presence => true
	validates :location, :presence => true 
	validates :start, :presence => true
	validates :end, :presence => true
	belongs_to :user

	scope :future, -> { where(:start => Time.now..'2200/01/01 12:00:00').sort_by_date }

	before_save :capitalize

	def capitalize
		self.description = self.description.capitalize
		self.location = self.location.capitalize
	end

	def self.list_events
		Event.all.each { |event| puts "#{event.id}. #{event.description} | #{event.location}, #{event.start} - #{event.end}"}
	end
end
