require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(name: "Admin", email: "admin@test.com", password: "password", password_confirmation: "password", admin: true)

    post "/sessions.json", params: { email: "admin@test.com", password: "password" }

    data = JSON.parse(response.body)
    @jwt = data["jwt"]
  end

  # Index Test
  test "index" do
    get "/products.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Product.count, data.length
  end

  # Show Test
  test "show" do
    get "/products/#{Product.first.id}.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal ["id", "name", "description", "price", "tax", "total", "supplier", "supplier_id", "images"], data.keys
  end

  # Create Test
  test "create" do
    # tests a successful response -> product created!
    assert_difference "Product.count", 1 do
      post "/products.json",
           headers: { "Authorization" => "Bearer #{@jwt}" },
           params: { name: "test product", price: 1, supplier_id: Supplier.first.id, description: "test description" }
    end

    # tests a product create without params -> aka, failed validations
    post "/products.json",
         headers: { "Authorization" => "Bearer #{@jwt}" },
         params: {}
    assert_response 422

    # tests a product create -> user is not an admin
    post "/products.json"
    assert_response 401
  end

  # Update Test
  test "update" do
    product = Product.first

    # tests successful product update action
    patch "/products/#{product.id}.json",
          headers: { "Authorization" => "Bearer #{@jwt}" },
          params: { name: "Updated name" }
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal "Updated name", data["name"]

    # tests uncessful product update action from an admin
    patch "/products/#{product.id}.json",
          headers: { "Authorization" => "Bearer #{@jwt}" },
          params: { name: "" }
    assert_response 422

    # tests uncessful product update action from a non-admin user
    patch "/products/#{product.id}.json"
    assert_response 401
  end

  # Destroy Test
  test "destroy" do
    # tests a successful product destroy action from an admin
    assert_difference "Product.count", -1 do
      delete "/products/#{Product.first.id}.json",
             headers: { "Authorization" => "Bearer #{@jwt}" }
      assert_response 200
    end

    delete "/products/#{Product.first.id}.json"
    assert_response 401
  end
end
