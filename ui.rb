require 'active_record'
require './lib/event'
require './lib/user'
require 'pry'

database_configuration = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configuration["development"]
ActiveRecord::Base.establish_connection(development_configuration)

def whitespace
  puts "\n"
end

def header
  system 'clear'
  puts "--MEETUP CALENDAR--"
  whitespace
end

def menu
	header
	choice = nil
	unless choice == 'x'
		puts " 1 - User Menu"
		puts " 2 - Event Menu"
		puts " x - Exit"
		choice = gets.chomp
		case choice
		when '1'
			user_menu
		when '2'
			event_menu
		when 'x'
			exit 
		else 
			puts "Invalid."
			menu
		end
	end
end

def user_menu
	header
	choice = nil
		unless choice == 'x'
		puts " 1 - Create User"
		puts " 2 - Edit User"
		puts " 3 - Delete User"
		puts " x - Main Menu"
		choice = gets.chomp
		case choice
		when '1'
			create_user
		when '2'
			edit_user
		when '3'
			delete_user
		else 
			puts "Invalid"
			menu
		end
	end
end

def event_menu
	header
	choice = nil
		unless choice == 'x'
		puts " 1 - Create Event"
		puts " 2 - Edit Event"
		puts " 3 - Delete Event"
		puts " x - Main Menu"
		choice = gets.chomp
		case choice
		when '1'
			create_event
		when '2'
			edit_event
		when '3'
			delete_event
		else 
			puts "Invalid"
			menu
		end
	end
end

def create_user
	header
	puts "Enter user name:"
	name = gets.chomp
	user = User.create(name: name)
	puts "#{user.name} has been added."
	user_menu
end

def list_users
	header
	User.all.each { |user| puts "#{user.id}. #{user.name}" }
end

def edit_user
	header
	list_users
	whitespace
	puts "Enter index # of user to update."
	update_user = User.find_by(id: gets.chomp.to_i)
	puts "Enter new name of user:"
	update_user.update(name: gets.chomp)
	puts "#{update_user.name} has been updated."
	sleep (2)
	menu
end

def delete_user
	header
	list_users
	puts "Enter index # of user to edit."
	delete_user = User.find_by(id: gets.chomp.to_i)
	delete_user.destroy
	puts "#{delete_user.name} has been deleted."
	sleep (2)
	menu
end

def list_events
	header
	Event.all.each { |event| puts "#{event.id}. #{event.description} | #{event.location}, #{event.start} - #{event.end}"}
end

def create_event
	header
	puts "Enter description of event:"
	description = gets.chomp
	puts "Enter location of event:"
	location = gets.chomp
	puts "Enter start time of event YYYY-DD-MM HH:MM:"
	start_time = gets.chomp
	puts "Enter end time of event YYYY-DD-MM HH:MM:"
	end_tme = gets.chomp
	event = Event.create(description: description, location: location, start: start_time, :end => end_tme)
	puts "#{event.description} | #{event.location}, #{event.start} - #{event.end} has been added."
	sleep (2)
	# menu
end

def edit_event

end

def delete_event

end


menu