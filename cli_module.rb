class CLI

  require 'date'

  def initialize contact
    @contact = contact
  end

  def create
    set_information
    @contact.save
  end

  def read
    puts "Put a contact name to search: "
    @contact.name gets.chomp
    @contact.find_by_name.each do |c|
      b = c['birthday'].to_s
      b = Date.parse(b)
      b = Date.new(b.year, b.month, b.day)
      puts "ID: #{c['_id']}"
      puts "Contact name: #{c['name']}\nContact lastname: #{c['lastname']}\nContact Birthday: #{b.day}/#{b.month}/#{b.year}\n"
    end
  end

  def update
    puts "Put an ID to select a contact"
    @contact.id gets.chomp
    set_information
    @contact.update
  end

  def delete
    puts "Put an ID to select a contact"
    @contact.id gets.chomp
    @contact.delete
  end

  def index
    puts "Here's your contact list: "
    @contact.index.each do |c|
      puts "#{c['name']} - #{c['lastname']}\n"
    end
  end

  private
    def set_information
      puts "Put a name: "
      @contact.name gets.chomp
      puts "Put a lastname: "
      @contact.lastname gets.chomp
      puts "Put a birthday(yyyy-mm-dd): "
      bd = gets.chomp
      bd = Date.parse bd
      bd = Date.new bd.year, bd.month, bd.day
      @contact.birthday bd
    end
end