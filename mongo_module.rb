# For MongoDB usage:
# https://docs.mongodb.com/ruby-driver/master/tutorials/ruby-driver-crud-operations/

class MongoModule

  require 'mongo'
  include Mongo

  def initialize
    Mongo::Logger.logger.level = ::Logger::FATAL
    get_database_setup
    @client = Mongo::Client.new(@setup[0], database: @setup[1])
  end

  def save name, lastname, birthday
    now = DateTime.new(Date.today.year, Date.today.month, Date.today.day)
    bd = DateTime.new(birthday.year, birthday.month, birthday.day)
    doc = { name: name, lastname: lastname, birthday: bd, created_at: now, updated_at: now }
    @client[@setup[2]].insert_one doc
  end

  def update id, name, lastname, birthday
    puts id.to_bson_key
    now = DateTime.new(Date.today.year, Date.today.month, Date.today.day)
    bd = DateTime.new(birthday.year, birthday.month, birthday.day)
    doc = { name: name, lastname: lastname, birthday: bd, created_at: now, updated_at: now }
    target = { _id: BSON::ObjectId(id) }
    @client[@setup[2]].update_one target, { "$set" => doc }
  end

  def read id
    @client[@setup[2]].find({ _id: BSON::ObjectId(id) })
  end

  def delete id
    @client[@setup[2]].find({ _id: BSON::ObjectId(id) } ).find_one_and_delete
  end

  def all_contacts
    @client[@setup[2]].find
  end

  def get_between start_date, end_date
    query = { updated_at: { "$gte": start_date, "$lt": end_date }, status: 1 } # {"$ne": 1}
    @contact = @client[@setup[2]].find( query )
  end

  def get_by_name name
    @contact = @client[@setup[2]].find({ name: name })
  end

  private
    def get_database_setup
      @setup = ["mongodb://localhost:27017", "ruby_sample", "contact_list"]
    end
end