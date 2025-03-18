# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
p = Patient.first
beginning_of_time = (Time.now-3.month).end_of_day
0.upto(720*3).each do |h|
#  p.metrics.create!({name: :blood_pressure_systolic, numeric_value: rand(70..99), taken_at: beginning_of_time+h.hours, unit: "mm Hg"})
#  p.metrics.create!({name: :blood_pressure_diastolic, numeric_value:  rand(100..150), taken_at: beginning_of_time+h.hours, unit: "mm Hg"})
#  p.metrics.create!({name: :heart_rate, numeric_value:  rand(60..100), taken_at: beginning_of_time+h.hours, unit: "bpm"})
#  p.metrics.create!({name: :blood_oxygen, numeric_value: rand(94..99), taken_at: beginning_of_time+h.hours, unit: "SpO2(%)"})
  p.metrics.create!({name: :blood_glucose, numeric_value: rand(90..110), taken_at: beginning_of_time+h.hours, unit: "mg/dL"})
end
