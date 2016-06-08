require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

	class << self
	  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`
		def print_results(contact_array)
			contact_array.each do |contact|
				puts "#{contact.id}: #{contact.name} (#{contact.email})"
			end
			puts "--- \n #{contact_array.length} records total"
		end

	end



	puts "Here is a list of available commands:
		new - Create a new contact
		list - List all contacts
		show - Show a contact by id
		search - Search contacts by search term (case sensitive)
		update - Update a contact by id"

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
			print_results(contact_list)
		
		when "show"
			found_contact = Contact.find(commands[:search_term])
			found_contact.each do |contact|
				puts "#{contact.id}: #{contact.name} (#{contact.email})"
			end
		
		when "search" 
		  search_results = Contact.search(commands[:search_term])
			print_results(search_results)

		when "update"
			puts "Enter name"	
			new_name = STDIN.gets.chomp
			puts "Enter email"
			new_email = STDIN.gets.chomp
			updated_contact = Contact.find(commands[:search_term])
			updated_contact.each do |contact|
				contact.name = new_name
				contact.email = new_email
				contact.save
				puts "Contact (#{contact.name}) successfully updated with an id of #{contact.id}"
			end

		when "destroy"
			deleted_contact = Contact.find(commands[:search_term])
			deleted_contact.each do |contact|
				contact.destroy
				puts "Contact (#{contact.name}) is gone forever!"
			end
			
		else
			puts "please enter a command when you run the program and try again"
	end

end

#####




