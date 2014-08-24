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
	puts "Enter index # of user to delete."
	delete_user = User.find_by(id: gets.chomp.to_i)
	delete_user.destroy
	puts "#{delete_user.name} has been deleted."
	sleep (2)
	menu
end

def create_event
 	header
  puts "Enter description of your event?"
  description = gets.chomp
  puts "Enter location of your event?"
  location = gets.chomp
  puts "Enter start date and time of your event? (YYYY-MM-DD HH:MM)"
  start_time = gets.chomp
  puts "Enter end date and time of your event? (YYYY-MM-DD HH:MM)"
  end_time = gets.chomp
  event = Event.create(description: description, location: location, start: start_time, :end => end_time)
  puts "#{event.description} | #{event.location} | #{event.start} | #{event.end}"
  menu
end

def edit_event
	header
	Event.list_events
	whitespace
	puts "Enter index # of event to update."
	update_event = Event.find_by(id: gets.chomp.to_i)
	puts "Enter new description:"
	update_event.update(description: gets.chomp)
	puts "Enter new location:"
	update_event.update(location: gets.chomp)
	puts "Enter new start time (YYYY-MM-DD HH:MM):"
	update_event.update(start: gets.chomp)
	puts "Enter new end time (YYYY-MM-DD HH:MM):"
	update_event.update(:end => gets.chomp)
	puts "#{update_event.description} has been updated."
	sleep (2)
	menu
end

def delete_event
	header
	# Event.list_events
	Event.future.each { |event| puts "#{event.id}. #{event.description} | #{event.start} | #{event.end} " } 
	puts "Enter index # of event to delete."
	delete_event = Event.find_by(id: gets.chomp.to_i)
	delete_event.destroy
	puts "#{delete_event.description} has been deleted."
	sleep (2)
	menu
end



menu