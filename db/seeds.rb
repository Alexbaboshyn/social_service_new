# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Place.delete_all
Place.create!(name: 'Beer&Blues',
              tags: ['karaoke', 'pub', 'restaurant', 'sushi'],
              city: 'Vinnytsia',
              lat: '49.2226476',
              lng: '28.4268502'
             )

Place.create!(name: 'Royal Pub',
              tags: ['pub'],
              city: 'Vinnytsia',
              lat: '49.2374337',
              lng: '28.490967'
             )

Place.create!(name: 'McDonald’s',
              tags: ['fastfud'],
              city: 'Vinnytsia',
              lat: '49.2325911',
              lng: '28.4751869'
             )

Place.create!(name: 'Solokha',
              tags: ['restaurant'],
              city: 'Vinnytsia',
              lat: '49.2290597',
              lng: '28.5013292'
             )

Place.create!(name: 'The Burger',
              tags: ['pub'],
              city: 'Kyjiv',
              lat: '50.4412025',
              lng: '30.5206713'
             )
