require 'pg'

# Represents a person in an address book.
# The ContactList class will work with Contact objects instead of interacting with the CSV file directly
class Contact

  attr_accessor :name, :email
  attr_reader :id

  @@conn = PG.connect({
  host: 'localhost',
  dbname: 'contacts',
  user: 'development',
  password: 'development'
  })

  # Creates a new contact object
  # @param name [String] The contact's name
  # @param email [String] The contact's email address
  def initialize(id=nil, name, email)
    # TODO: Assign parameter values to instance variables.
    @id = id
    @name = name
    @email = email
  end

  # Provides functionality for managing contacts in the csv file.
  class << self    

    def all
      # TODO: Return an Array of Contact instances made from the data in 'contacts.csv'.
      #puts contacts
      results = []
      @@conn.exec("SELECT * FROM contacts ORDER BY id ASC;").each do |contact|
        results << Contact.new(contact["id"], contact["name"], contact["email"])
      end
      results
    end

    def create(name, email)
      # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
      #create new contact & add a new name, email and increment the id
      # new_name = name
      # new_email = email
      # new_id = CSV.read('contacts.csv').length + 1

      # CSV.open('contacts.csv', 'a') do |row| 
      #   row << [new_id,new_name,new_email]
      # end
      # return new_id
    end

    # save is a 'helper method' for create
    def save
      if id
        @@conn.exec("UPDATE contacts SET id=$1, name=$2, email=$3;", 
        [id.to_i, name, email])
      else
        result = @@conn.exec("INSERT INTO contacts (id, name, email) 
        VALUES ($1, $2, $3) RETURNING id;", 
        [id.to_i, name, email])
        @id = result.first["id"].to_i
      end 
      self
    end

    # Find the Contact in the 'contacts.csv' file with the matching id.
    # @param id [Integer] the contact id
    # @return [Contact, nil] the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      # TODO: Find the Contact in the 'contacts.csv' file with the matching id.

      # CSV.foreach('contacts.csv') do |row|

      #     if row[0] == id.to_s
      #       puts "the matching row is #{row}"
      #       return row
      #     end

      # end

      # return "ID (#{id}) not found. Please enter another ID."    
    end

    # Search for contacts by either name or email.
    # @param term [String] the name fragment or email fragment to search for
    # @return [Array<Contact>] Array of Contact objects.
    def search(term)
      # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
      # found_records = []

      # if !term.nil?

      #   CSV.foreach('contacts.csv') do |row|

      #     if (row[1].include? term.to_s) || (row[2].include? term.to_s)
      #       found_records << row
      #     end

      #   end

      # end      

      # return found_records   
    end

  end

end
