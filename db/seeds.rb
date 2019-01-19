# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Product.create(title: "tequila", price: 10.65, inventory_count: 100)
Product.create(title: "vodka", price: 8.92, inventory_count: 46)
Product.create(title: "whiskey", price: 25.99, inventory_count: 21)
Product.create(title: "rum", price: 12.15, inventory_count: 79)
Product.create(title: "soju", price: 9.01, inventory_count: 5)
Product.create(title: "beer", price: 3.52, inventory_count: 37)
Product.create(title: "jagermeister", price: 20.2, inventory_count: 0)
