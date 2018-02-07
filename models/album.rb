require('pg')
require_relative('../db/sql_runner.rb')

class Album

  attr_reader :id, :name, :genre, :artist_id

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

end
