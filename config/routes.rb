Rails.application.routes.draw do
  get "/allproducts" => "products#print_products"
end
