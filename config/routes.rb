Rails.application.routes.draw do
  get "/allproducts", controller: "products", action: "print_products"
end
