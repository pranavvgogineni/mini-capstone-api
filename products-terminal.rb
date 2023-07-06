require "http"

system "clear"

puts "Welcome to products app!"
products = HTTP.get("http://localhost:3000/allproducts.json")
pp products.parse
