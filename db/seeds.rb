# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  Rake::Task['db:fixtures:load'].invoke
  User.delete_all
  Preference.delete_all
  user = User.create(:first_name => "Tom", :last_name => "Ridge", :description => "I have an odd obsession with Lego", :title => "Mr", :profile_link => "https://twitter.com/tjridge", :avatar => "chicken" )
  Preference.create(:user => user, :name => "Pizza")
  Preference.create(:user => user, :name => "Chips")
  Preference.create(:user => user, :name => "Burritos")