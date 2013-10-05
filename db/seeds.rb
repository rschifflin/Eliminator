# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
season = Season.where(year: 2013).first_or_create
week = Week.where(season: season).first_or_create


#NFC NORTH 
Team.where(location: "Minnesota",
           name: "Vikings").first_or_create
Team.where(location: "Green Bay",
           name: "Packers").first_or_create
Team.where(location: "Detroit",
           name: "Lions").first_or_create
Team.where(location: "Chicago",
           name: "Bears").first_or_create

#NFC EAST
Team.where(location: "Dallas",
           name: "Cowboys").first_or_create
Team.where(location: "New York",
           name: "Giants").first_or_create
Team.where(location: "Philadelphia",
           name: "Eagles").first_or_create
Team.where(location: "Washington",
           name: "Redskins").first_or_create

#NFC SOUTH
Team.where(location: "Atlanta",
           name: "Falcons").first_or_create
Team.where(location: "New Orleans",
           name: "Saints").first_or_create
Team.where(location: "Tampa Bay",
           name: "Buccaneers").first_or_create
Team.where(location: "Carolina",
           name: "Panthers").first_or_create

#NFC WEST
Team.where(location: "San Francisco",
           name: "49ers").first_or_create
Team.where(location: "Seattle",
           name: "Seahawks").first_or_create
Team.where(location: "Arizona",
           name: "Cardinals").first_or_create
Team.where(location: "St. Louis",
           name: "Rams").first_or_create

#AFC NORTH 
Team.where(location: "Pittsburgh",
           name: "Steelers").first_or_create
Team.where(location: "Baltimore",
           name: "Ravens").first_or_create
Team.where(location: "Cleveland",
           name: "Browns").first_or_create
Team.where(location: "Cincinnati",
           name: "Bengals").first_or_create

#AFC EAST
Team.where(location: "New England",
           name: "Patriots").first_or_create
Team.where(location: "Buffalo",
           name: "Bills").first_or_create
Team.where(location: "Miami",
           name: "Dolphins").first_or_create
Team.where(location: "New York",
           name: "Jets").first_or_create

#AFC SOUTH
Team.where(location: "Tennessee",
           name: "Titans").first_or_create
Team.where(location: "Indianapolis",
           name: "Colts").first_or_create
Team.where(location: "Jacksonville",
           name: "Jaguars").first_or_create
Team.where(location: "Houston",
           name: "Texans").first_or_create

#AFC WEST
Team.where(location: "Denver",
           name: "Broncos").first_or_create
Team.where(location: "San Diego",
           name: "Chargers").first_or_create
Team.where(location: "Kansas City",
           name: "Chiefs").first_or_create
Team.where(location: "Oakland",
           name: "Raiders").first_or_create


matchups = Team.all.shuffle.each_slice(2).to_a
matchups.each do |pair|
  Game.where(home_team: pair.first,
             away_team: pair.second,
             week: week,
             progress: "next").first_or_create
end

