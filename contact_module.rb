class Contact

  def initialize mongo
    @mongo = mongo
  end

  def index
    @mongo.all_contacts
  end

  def find_by_name
    @mongo.get_by_name @name
    # @mongo.get_between start_date, end_date
    # @mongo.get_by_id id
  end

  def save
    @mongo.save @name, @lastname, @birthday
  end

  def update
    @mongo.update @id, @name, @lastname, @birthday
  end

  def delete
    @mongo.delete @id
  end
end