# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Employee.create(name: 'Admin GTI',email: 'admin@hotel.com', password: 'admin123')
Sector.create(name: 'Todos')
Sector.create(name: 'Portaria')
Sector.create(name: 'Garçons')
Department.create(name: 'Todos')
Department.create(name: 'Cozinha')
Department.create(name: 'Recepçao')