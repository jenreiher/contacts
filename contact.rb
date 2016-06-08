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

   # save is a 'helper method' for create
  def save
    if id
      @@conn.exec("UPDATE contacts SET id=$1, name=$2, email=$3;", 
      [id.to_i, name, email])
    else
      result = @@conn.exec("INSERT INTO contacts (name, email) 
      VALUES ($1, $2) RETURNING id;", 
      [name, email])
      @id = result[0]["id"].to_i
    end 
    self
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
      new_contact = Contact.new(name, email)
      new_contact.save
      new_contact
    end

    # Find the Contact in the 'contacts.csv' file with the matching id.
    # @param id [Integer] the contact id
    # @return [Contact, nil] the contact with the specified id. 
    # If no contact has the id, returns nil.
    def find(id)
      results = []
      unless id.nil?
        @@conn.exec("SELECT * FROM contacts WHERE name LIKE $1::int", [id]).each do |contact|
          results << Contact.new(contact["id"], contact["name"], contact["email"])
          # @return [Contact, nil] the contact with the specified id. 
          # If no contact has the id, returns nil.
        end
      else
        nil
      end
      results    
    end

    # Search for contacts by either name or email.
    # @param term [String] the name fragment or email fragment to search for
    # @return [Array<Contact>] Array of Contact objects.
    def search(term)
      search_for = '%' + term.to_s + '%'
      results = []
      unless term.nil?
        @@conn.exec("SELECT * FROM contacts WHERE name LIKE $1;", [search_for]).each do |contact|
          results << Contact.new(contact["id"], contact["name"], contact["email"])
        end
      else
        nil   
      end
      results 
    end

  end

end
