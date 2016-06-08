require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

	class << self
	  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`
	end
end

#####

puts "Here is a list of available commands:
		new - Create a new contact
		list - List all contacts
		show - Show a contact
		search - Search contacts"

commands = Hash.new
commands[:command] = ARGV[0]
commands[:search_term] = ARGV[1]

case commands[:command]

	when "new"
		puts "Enter name"	
		name = STDIN.gets.chomp
		puts "Enter email"
		email = STDIN.gets.chomp
		created_contact = Contact.create(name,email)
		puts "Contact (#{created_contact.name}) successfully created with an id of #{created_contact.id}"
	
	when "list"
		contact_list = Contact.all
		contact_list.each do |contact|
			puts "#{contact.id}: #{contact.name} (#{contact.email})"
		end
		puts "--- \n #{contact_list.length} records total"

	
	when "show"
		found_contact = Contact.find(commands[:search_term])
		found_contact.each do |contact|
			puts "#{contact.id}: #{contact.name} (#{contact.email})"
		end
	
	when "search" 
	  search_results = Contact.search(commands[:search_term])
		search_results.each do |contact|
			puts "#{contact.id}: #{contact.name} (#{contact.email})"
		end
		puts "--- \n #{search_results.length} records total"
	
	else
		puts "please enter a command when you run the program and try again"

end


