require('pg')
require_relative('../db/sql_runner.rb')

class Artist

  attr_reader :id, :name

  def initialize(options)
    @id = options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists (name) VALUES ($1) RETURNING *"
    values = [@name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
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

end
