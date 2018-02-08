require('pg')
require_relative('../db/sql_runner.rb')

class Artist

  attr_accessor :id, :name

  def initialize(options)
    @id = options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists (name) VALUES ($1) RETURNING *"
    values = [@name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def delete()
    # in order to delete artists, you must first delete all their albums
    values = [@id] # same Value used in both SQL statements
    sql = "DELETE FROM albums WHERE artist_id = $1"
    SqlRunner.run(sql, values)
    sql = "DELETE FROM artists WHERE id = $1"
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def self.list_all()
    sql = "SELECT * FROM artists"
    result = SqlRunner.run(sql)
    return result.map{|artist| Artist.new(artist)}
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    result = SqlRunner.run(sql,values)
    return result.map{|album| Album.new(album)}
  end

  def update()
    sql = "UPDATE artists SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    # assign DATABASE output to a variable
    result = SqlRunner.run(sql, values)
    # map this into an array of Artist objects
    array_result = result.map{|artist| Artist.new(artist)}
    # if the array contains an object, return it
    # else inform user it doesn't exist
    if array_result.length > 0
      return array_result[0]
    else
      return "This artist does not exist."
    end
  end

end
