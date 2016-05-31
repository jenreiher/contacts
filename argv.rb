#puts ARGV

contact_command = Hash.new

contact_command[:command] = ARGV[0]
contact_command[:full_name] = ARGV[1]
contact_command[:email] = ARGV[2]

puts contact_command