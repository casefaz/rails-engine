# Rails Engine
> A week long solo API-only project that implements endpoints using RESTful convention

![Postman Badge](https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=Postman&logoColor=white)
![JSON Badge](https://img.shields.io/badge/json-5E5C5C?style=for-the-badge&logo=json&logoColor=white)
![Ruby/Rails](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white)

Utilizing service-oriented architecture this project exposes the data powering a movie database through RESTful conventions and test driven development. [Rails Engine Requirements](https://backend.turing.edu/module3/projects/rails_engine_lite/requirements)
  * [Go to testing section](#testing)
  * [Go to endpoints](#endpoints)
  * [Go to potential refactor opportunity](#potential-refactor)
  * [Go to Learning Outcomes](#learning-outcomes)

## Testing

Gems, Ruby, and Rails Versions:

```sh
jsonapi-serializer
factory_bot_rails
faker
rspec-rails
shoulda-matchers
simplecov
ruby 2.7.4
rails 5.2.8
```
Postman: 

![Screen Shot 2022-07-14 at 6 36 35 PM](https://user-images.githubusercontent.com/98674727/179123982-1ff08247-3d23-40b9-b5e1-20773c2e1cf7.png)
![Screen Shot 2022-07-14 at 6 36 24 PM](https://user-images.githubusercontent.com/98674727/179123783-3ec99ff9-9651-4e47-8974-cd0baf284e39.png)
![Screen Shot 2022-07-14 at 6 36 56 PM](https://user-images.githubusercontent.com/98674727/179123807-c560515f-e67d-4185-8c26-49366242efe4.png)

Simplecov:

![Screen Shot 2022-07-14 at 6 42 14 PM](https://user-images.githubusercontent.com/98674727/179124152-3b306bf5-fe15-4ca3-ab83-339c404f62d2.png)
![Screen Shot 2022-07-14 at 6 42 53 PM](https://user-images.githubusercontent.com/98674727/179124212-4704fdf5-1e61-4453-8aab-1487a7e86adb.png)

If time was limitless I would: 
* refactor the test paths for better developer empathy re: encapsulating each CRUD action in one file (better potential for cleaner code on a larger scale)

[Return to Header](#rails-engine)
## Endpoints
### First Endpoint
Get an Items Merchant
* Files impacted: 
  * [Routes](#routes)
  * [Merchants Controller](#controller)
  * [Item Spec](#spec)
  * Merchant Serializer
  
### Routes
```sh
namespace :api do
  namespace :v1 do
    resources :items do 
      get '/merchant', to: 'merchants#show'
    end
  end
end
```
### Controller
```sh
def show
  if Item.exists? && params[:item_id]
    merchant = Item.find(params[:item_id]).merchant
    render json: MerchantSerializer.new(merchant)
  else
    merchant2 = Merchant.find(params[:id])
    render json: MerchantSerializer.new(merchant2)
  end
end
```
### Spec
Happy path: successfully produce the endpoint
```sh
merchant = create(:merchant)
item = create(:item, merchant_id: merchant.id)

get "/api/v1/items/#{item.id}/merchant"

expect(response).to be_successful
expect(response).to have_http_status(200)

parsed_merchant = JSON.parse(response.body, symbolize_names: true)

expect(parsed_merchant[:data].keys.count).to eq(3)
expect(parsed_merchant[:data][:attributes].count).to eq(1)
expect(parsed_merchant[:data][:attributes][:name]).to eq(merchant.name)
```
Sad path: return an error if the id is invalid
```sh
it 'returns an error with a bad item id' do
  get '/api/v1/items/45293/merchant'

  expect(response).to have_http_status(404)
end

it 'returns an error if the id comes through as a string' do
  get "/api/v1/items/'45293'/merchant"

  expect(response).to have_http_status(404)
end
```
### Second Endpoint
Find All Items
* Files impacted: 
  * [Routing](#routing)
  * [Item Model](#item-model)
  * [Search Controller](#search-controller)
  * [Find all Items Spec](#find-all-spec)
  * Item Serializer
  
### Routing
Includes all routes
```sh
namespace :api do
  namespace :v1 do
    get 'merchants/find', to: 'merchants/search#index'
    get 'items/find_all', to: 'items/search#index'
    resources :merchants, only: %i[index show] do
      resources :items, only: [:index], controller: 'merchant_items'
    end
    resources :items do
      get '/merchant', to: 'merchants#show'
    end
  end
end
```
### Item Model
```sh
def self.find_name(query)
  where('name ILIKE ?', "%#{query}%")
end

def self.find_min_price(price)
  where('unit_price >= ?', price.to_s)
end

def self.find_max_price(price)
  where('unit_price <= ?', price.to_s)
end

def self.find_min_and_max_price(min_price, max_price)
  where("unit_price >= #{min_price} AND unit_price <= #{max_price}")
end
```
### Search Controller
```sh
def index
      if valid_query
        if params[:name] 
          item = Item.find_name(params[:name])
          render json: ItemSerializer.new(item)
        elsif params[:min_price] && params[:max_price]
          item = Item.find_min_and_max_price(params[:min_price], params[:max_price])
          render json: ItemSerializer.new(item)
        elsif params[:min_price]
          item = Item.find_min_price(params[:min_price])
          render json: ItemSerializer.new(item)
        elsif params[:max_price]
          item = Item.find_max_price(params[:max_price])
          render json: ItemSerializer.new(item)
        end
      else
        render json: { response: 'Bad Request' }, status: :bad_request
      end
    end

    def valid_query
      name = (params[:name] && params[:name] != '') && !params[:min_price] && !params[:max_price]
      min_or_max = !params[:name] && (!params[:min_price].nil? || !params[:max_price].nil?)
      min_and_max_price = !params[:name] && (!params[:min_price].nil? && !params[:max_price].nil?)

      name || min_or_max || min_and_max_price
    end
  end 
end
```
### Find All Spec
Happy path: finds the item by name, min, and max price parameters
Name
```sh
item1 = create(:item, name: 'white rice')
item2 = create(:item, name: 'brown rice')
item3 = create(:item, name: 'fried rice')
item4 = create(:item, name: 'sesame ball')

get '/api/v1/items/find_all?name=rice'

found_items = JSON.parse(response.body, symbolize_names: true)
expect(found_items[:data].count).to eq(3)

found_items[:data].each do |item|
  expect(item).to have_key(:id)
  expect(item[:attributes].keys.count).to eq(4)
  expect(item[:attributes]).to have_key(:name)
  expect(item[:attributes]).to have_key(:description)
  expect(item[:attributes]).to have_key(:merchant_id)
  expect(item[:attributes]).to have_key(:unit_price)
  expect(item[:attributes]).to_not have_key(:created_at)
end
```
Price
```sh
get '/api/v1/items/find_all?min_price=4'

expect(response).to be_successful
expect(response).to have_http_status(200)

parsed_min = JSON.parse(response.body, symbolize_names: true)
expect(parsed_min[:data].count).to eq(3)

get '/api/v1/items/find_all?max_price=4'

expect(response).to be_successful
expect(response).to have_http_status(200)

parsed_max = JSON.parse(response.body, symbolize_names: true)

expect(parsed_max[:data].count).to eq(2)

get '/api/v1/items/find_all?min_price=1&max_price=4'

expect(response).to be_successful
expect(response).to have_http_status(200)

parsed_min_max = JSON.parse(response.body, symbolize_names: true)

expect(parsed_min_max[:data].count).to eq(2)
```
Sad path: incorrect parameters
```sh
get '/api/v1/items/find_all?name=deckofmanythings'

expect(response).to be_successful
expect(response).to have_http_status(200)

parsed_response = JSON.parse(response.body, symbolize_names: true)
expect(parsed_response[:data]).to eq([])

get '/api/v1/items/find_all?name=coriander&min_price=2'

expect(response).to have_http_status(400)

get '/api/v1/items/find_all?name=coriander&min_price=2&max_price=5'

expect(response).to have_http_status(400)

get '/api/v1/items/find_all'

expect(response).to have_http_status(400)
```
[Return to Header](#rails-engine)

## Potential Refactor

If I had all the time in the world: 
* Refactor Items Merchant into it's own controller
* Combine all the model methods into one to shorten controller
* Put repetitive `render json:` error paths into Module
* Do edge casing on top of of sad-pathing


## Learning Outcomes

* RESTful API conventions
    * routing
    * encapsulating logic and files in places that promote developer empathy and common sense
* Abstract logic out of the controllers
    * modules
    * model methods
* Be patient with yourself
    * Work in progress
