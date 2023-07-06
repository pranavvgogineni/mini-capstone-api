puts "Seeding starting"
product3 = Product.new({ name: "Monitor", price: 300, image_url: "insert", description: "Screen" })
product3.save
product4 = Product.new({ name: "Wallet", price: 10, image_url: "insert", description: "tool to hold cards and money" })
puts "Seeding ending"
product4.save
