require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

	class << self
	  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`

	  def new_contact(name,email)
	  	return Contact.create(name,email)
	  end
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
		new_id = ContactList.new_contact(name,email)
		puts "Contact successfully created with the id #{new_id}"
	
	when "list"
		contact_list = Contact.all
		contact_list.each do |contact|
			puts "#{contact.id}: #{contact.name} (#{contact.email})"
		end
		puts "--- \n #{contact_list.length} records total"

	
	when "show" then puts Contact.find(search_term)
	
	when "search" 
	  results = Contact.search(search_term)
		results.each do |contact|
			puts "#{contact[0]}: #{contact[1]} (#{contact[2]})"
		end
		puts "--- \n #{results.length} records total"
	
	else
		puts "please enter a command when you run the program and try again"

end


