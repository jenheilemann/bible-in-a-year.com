require 'csv'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

options = { headers: true, quote_char: '"' }
data = CSV.read(File.join(Rails.root, 'db', 'readings.csv'), options)
ReadingsImporter.new(data).run
