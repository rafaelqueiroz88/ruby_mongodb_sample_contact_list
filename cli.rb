#!/usr/bin/ruby
require_relative 'cli_module'
require_relative 'contact_module'
require_relative 'mongo_module'

mongo = MongoModule.new

contact = Contact.new mongo
cli = CLI.new contact

puts "Welcome to Ruby-MongoDB\n"
cli.index

while true
  puts "\nType a command to continue...\nPossible commands: (c)create, (r)read, (u)update, (d)delete...\nType: "
  command = gets.chomp

  case command.to_s
  when "create"
    cli.create
  when "read"
    cli.read
  when "update"
    cli.update
  when "delete"
    cli.delete
  when "end"
    exit 1
  end
  puts "\n"
  cli.index
end