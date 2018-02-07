require('pg')
require_relative('../db/sql_runner.rb')

class Album

  attr_accessor :id, :name, :genre, :artist_id

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @genre = options['genre']
    @artist_id = options['artist_id']
  end

  def save()
    sql = "INSERT INTO albums (name, genre, artist_id)
           VALUES ($1, $2, $3) RETURNING *"
    values = [@name, @genre, @artist_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.list_all()
    sql = "SELECT * FROM albums"
    result = SqlRunner.run(sql)
    return result.map{|album| Album.new(album)}
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    return SqlRunner.run(sql, values).first
  end

  def update()
    sql = "UPDATE albums SET (name, genre, artist_id)
           = ($1, $2, $3) WHERE id = $4"
    values = [@name, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    # assign DATABASE output to variable
    result = SqlRunner.run(sql, values)
    # Map result into an array of Objects
    array_result = result.map{|album| Album.new(album)}
    # if the array is NOT EMPTY, return the Album object,
    # otherwise, inform user it does not exist.
    if array_result.length > 0
      return array_result[0]
    else
      return "Album does not exist"
    end
  end

  def self.find_by_genre(genre)
    genre.downcase! # catch any stray Capitals
    sql = "SELECT * FROM albums WHERE genre = $1"
    values = [genre]
    # assign DATABASE output to variable
    result = SqlRunner.run(sql, values)
    # Map result into an array of Objects
    array_result = result.map{|album| Album.new(album)}
    # if the array is NOT EMPTY, return the Album object,
    # otherwise, inform user it does not exist.
    if array_result.length > 0
      return array_result
    else
      return "No albums of that genre."
    end
  end

end
