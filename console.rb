require('pry-byebug')
require_relative('./models/album.rb')
require_relative('./models/artist.rb')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({'name' => 'Oneohtrix Point Never'})
artist2 = Artist.new({'name' => 'Iannis Xenakis'})
artist3 = Artist.new({'name' => 'Ought'})
artist4 = Artist.new({'name' => 'Christian Scott'})
artist5 = Artist.new({'name' => 'Barry Manilow'}) # has no ablums

artists = [artist1, artist2, artist3, artist4, artist5]

for artist in artists
  artist.save
end

album1 = Album.new({
  'artist_id'=> artist1.id,
  'name' => 'Garden of Delete',
  'genre' => 'electronic'
})
album2 = Album.new({
  'artist_id'=> artist1.id,
  'name' => 'Replica',
  'genre' => 'electronic'
})
album3 = Album.new({
  'artist_id'=> artist1.id,
  'name' => 'Returnal',
  'genre' => 'electronic'
})
album4 = Album.new({
  'artist_id'=> artist2.id,
  'name' => 'Chamber Music: 1955 - 1990',
  'genre' => 'classical'
})
album5 = Album.new({
  'artist_id'=> artist2.id,
  'name' => 'La Legende D\'Eer',
  'genre' => 'classical'
})
album6 = Album.new({
  'artist_id'=> artist3.id,
  'name' => 'Sun Coming Down',
  'genre' => 'alternative'
})
album7 = Album.new({
  'artist_id'=> artist3.id,
  'name' => 'More Than Any Other Day',
  'genre' => 'alternative'
})
album8 = Album.new({
  'artist_id'=> artist4.id,
  'name' => 'Stretch Music',
  'genre' => 'jazz'
})
album9 = Album.new({
  'artist_id'=> artist4.id,
  'name' => 'Yesterday You Said Tomorrow',
  'genre' => 'jazz'
})

albums = [album1, album2, album3, album4, album5, album6, album7, album8, album9]

# save all the albums
for album in albums
  album.save
end

# ###  TESTING Update ARTIST NAME  ###
# artist1.name = 'Richard Nixon'
# artist1.update()

# ###  TESTING Update ARTIST NAME  ###
# album9.name = 'I hate this album'
# album9.update()
# album4.genre = 'Showtunes'
# album4.update()

### TESTING DELETE ALBUM ###
# album7.delete()

### TESTING DELETE ARTIST ###
# this command will delete both the ARTIST and all their ALBUMS
# artist2.delete()


binding.pry

nil
