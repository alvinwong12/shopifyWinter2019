# Alvin Wong Marketplace API Documentation

API for consumers to find out product info and shop from the marketplace.

## Root
https://evening-harbor-15855.herokuapp.com/

Example API Request:
```
https://evening-harbor-15855.herokuapp.com/products
```

## Products

##### GET /products
Get all products info.

###### Query string parameters

| Parameter | Description |
| ------ | ------ |
| product_id | product unique id |
| title  | name of the product |
| price  | price of the product |
| inventory_count | Amount of available product |
| available_products_only | Restricts results to products with available inventory. Default to false. |
| count | Restricts number of results. Default to no restrictions |

Example query:
```
/products?title="apple"&inventory_count=1&price=1.2&product_id=123&available_products_only=true&count=1
```

###### Response body
Return a JSON Array of products. See below for product parameters.

##### GET /products/:product_id
Get info of a product with the provided <product_id>

###### Response body
Return a JSON representation of the product.

##### Product parameter
| Parameter | Description|
|-----------| -----------|
| product_id | product unique id |
| title  | name of the product |
| price  | price of the product |
| inventory_count | Amount of available product |
| created_at | The date and time (ISO 8601 format) of when the product is created |
| updated_at | The date and time (ISO 8601 format) of when the product is updated |

## Carts

##### GET /carts
Get all carts info

###### Response body
Return a JSON Array of carts. See below for cart parameters.

##### GET /carts/:cart_id
Get info of a product with the provided <cart_id>

###### Response body
Return a JSON representation of the cart. See below for cart parameters.

##### POST /carts
Create a cart

###### Response body
Return a JSON representation of the new created cart. See below for cart parameters.

##### POST /carts/:cart_id/products
Add products to the cart <cart_id>. A cart already activated is not allowed to 
be added to.

###### Request parameters
|Parameter| Description|
|-----------|----|
|products| JSON Array of products specified with <product_id> and <quantity>|
|product_id| Product unique id. Missing or invalid product_id would cause imcompletion of request|
|quantity|Amount of product to be added. Value of >=0 is accepted. Missing or invalid quantity would cause imcompletion of request|

Example Request:
```
{
  "products":[
    {
      "product_id": "1889652969987633926",
      "quantity": 2
    },
    {
      "product_id": "2461571134538233439",
      "quantity": 1
    }
  ]
}
```
###### Response body
Return a JSON representation of the cart with added products. See below for cart parameters.

##### POST /carts/:cart_id/activate
Activate a cart and checkout all items. An item without sufficient inventory will halt the activation of the cart. A cart cannot be activated twice.

###### Response body
Return a JSON representation of the cart with completion status 'true'

##### PUT /carts/:cart_id/products
Update quantities of current products in the cart. Product that is currently not in cart cannot be updated, therefore not able to complete the request. An activated cart cannot be updated.

###### Request parameters
|Parameter| Description|
|-----------|----|
|products| JSON Array of products specified with <product_id> and <quantity>|
|product_id| Product unique id. Missing or invalid product_id would cause imcompletion of request|
|quantity|Amount of product to be added. Value of >=0 is accepted. Missing or invalid quantity would cause imcompletion of request. A quantity of 0 will remove product from cart|

Example Request:
```
{
  "products":[
    {
      "product_id": "1889652969987633926",
      "quantity": 2
    },
    {
      "product_id": "2461571134538233439",
      "quantity": 0
    }
  ]
}
```

###### Response body
Return a JSON representation of the cart with updated products

##### DELETE /carts/:cart_id
Remove cart <cart_id>

###### Response body
Return a '204' response on succession

##### Cart parameter
| Parameter | Description|
|-----------| -----------|
| cart_id | cart unique id |
| total  | total value of all products in the cart. Default to 0 |
| completed  | completion status of the cart. Default to false |
| cart_items | JSON Array of cart items currently in the cart |

##### Cart_item Parameter
|Parameter|Description|
|---|---|
|quantity|amount of product|
|product|see above for product parameters|

##### Error Response
Responds to imcompletion of requests due to client input

###### Response body parameter
|Parameter| Description|
|-|-|
|status| "error"|
|message|Explaination of request failure|

Example error response:
```
{
    "status": "error",
    "message": "XXX"
}
```

## Local Project Setup

Ruby version of '2.5.3' is required

```
git clone https://github.com/alvinwong12/shopifyWinter2019.git && cd shopify2019
bundle install
rake db:create
rake db:migrate
rake db:seed

bin/rails server 
```