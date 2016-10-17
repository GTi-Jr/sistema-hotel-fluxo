# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Sector.create(name: 'Todos')
Sector.create(name: 'Portaria')
Sector.create(name: 'Garçons')
Department.create(name: 'Todos')
Department.create(name: 'Cozinha')
Department.create(name: 'Recepçao')
Employee.create(name: 'Admin GTI',email: 'admin@hotel.com', password: 'admin123', sector_id: '1', department_id: '1',code: '123', admin:true)