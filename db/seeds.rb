# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#User.delete_all
Request.delete_all
Reply.delete_all

#User.create(name: "Ahmed Saleh", email: "ahmed@domain.com", phone: "01115228310", age: 20, ID: "01234567897777")


Request.create(patient_name: "Mohamed", contact_name: "Ali", contact_phone: "01115228330", national_id: "01234567891111", blood_type: "A+", due_date: 12-5-2015, hospital_name: "Int. Hospital", hospital_phone: "022575886", email: "ali@domain.com", blood_bags: 1)

Request.create(patient_name: "Sherif", contact_name: "Jones", contact_phone: "01115228333", national_id: "01234567890111", blood_type: "A+", due_date: 12-5-2015, hospital_name: "Int. Hospital", hospital_phone: "022575886", email: "jones@domain.com", blood_bags: 1)

Request.create(patient_name: "Albert", contact_name: "Barbra", contact_phone: "01115228334", national_id: "01234567892111", blood_type: "B+", due_date: 12-5-2015, hospital_name: "Int. Hospital", hospital_phone: "022575886", email: "barbra@domain.com", blood_bags: 2)