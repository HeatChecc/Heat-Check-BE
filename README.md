<img src= "https://user-images.githubusercontent.com/102835975/197584377-1c3bb80f-8b75-48ec-bbfa-90d29d676ec2.png" width=100% height=80%>

# README

 # Project Overview
🔥  Heat Check 🔥  is an app that helps spicy food lovers to explore restaurants that have an appropriate spice level to match. It allows users to search for restaurants with spicy dishes, add new dishes, review them, and rate their spiciness level.

🔥 Check out the front-end repo [here](https://github.com/HeatChecc/Heat-Check-FE)

## 🔥 Built With
[<img src="https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white"/>](https://www.ruby-lang.org/en/) <br>
[<img src="https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white"/>](https://rubyonrails.org/) <br>
<img src="https://img.shields.io/badge/Heroku-430098?style=for-the-badge&logo=heroku&logoColor=white"/><br>
<img src="https://img.shields.io/badge/GraphQl-E10098?style=for-the-badge&logo=graphql&logoColor=white"/><br>
<img src="https://img.shields.io/badge/circleci-343434?style=for-the-badge&logo=circleci&logoColor=white"/><br>
[<img src="https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=Postman&logoColor=white"/>](https://www.postman.com/product/what-is-postman/)<br>



# 🔥 Schema

<img width="808" alt="Screen Shot 2022-10-24 at 9 50 38 AM" src="https://user-images.githubusercontent.com/102835975/197570071-eb92b44c-7928-455a-bdd4-6025fdbb637f.png">

# 🔥 API Endpoints
The following endpoints are exposed, and all endpoints begin with this base URL: [https://heatcheck-be.herokuapp.com/](https://heatcheck-be.herokuapp.com/) , and all Graphql endpoints respond to POST /graphql requests only. Query information will need to be sent in the body of the request.

### RESTAURANTS by LOCATION:
```ruby
query Restaurants($location: String! ) {
  restaurants(location: $location) {
    id
    name
    rating
    address
    lat
    lon
    city
  }
}
```

### RESTAURANT and its DISHES by YELP ID:
```ruby
query Restaurant($yelp_id: String! ) {
  restaurant(id: $yelp_id) {
    id
    name
    rating
    price
    imageUrl
    url
    categories
    address
    phone
    lat
    lon
    city
    dishes {
      id
      name
      cuisineType
      yelpId
      spiceRating
      }
    }
  }
  ```

### ALL USERS:
```ruby
query {
  users {
    id
    email
    username
  }
}
```

### USER by ID:
```ruby
query User($id: String! ) {
  user(id: $id) {
    id
    email
    username
  }
}
```

### USER and its REVIEWS by ID:
```ruby
query User($id: String! ) {
  user(id: $id) {
    id
    email
    username
    reviews {
          id
          description
          overallRating
          userId
          dishId
    }
  }
}
```

### ALL DISHES:
```ruby
query {
  dishes {
    id
    name
    cuisineType
    yelpId
    spiceRating
  }
}
```

### DISH by ID:
```ruby
query Dish($id: String! ) {
  user(id: $id) {
    id
    name
    cuisineType
    yelpId
    spiceRating
  }
}
```

### DISH and its REVIEWS by ID:
```ruby
query Dish($id: String! ) {
  dish(id: $id) {
    id
    name
    cuisineType
    yelpId
    spiceRating
    reviews {
          id
          description
          overallRating
          userId
          dishId
    }
  }
}
```

### ALL REVIEWS:
```ruby
query {
  reviews {
    id
    description
    overallRating
    userId
    dishId
  }
}
```

### REVIEW by ID:
```ruby
query Review($id: String! ) {
  user(id: $id) {
    id
    description
    overallRating
    userId
    dishId
  }
}
```

### CREATE USER:
```ruby
mutation {
  user: createUser(
    input: {
      email: "hello@hello.com"
      username: "hello"
    }
  ) {
    email
    username
    }
  }
  ```

### UPDATE USER:
```ruby
mutation {
  user: updateUser(
    input: {
      id: "$id"
      username: "superphil"
      email: "phil@phil.com"
    }
    ) {
      username
      email
  }
}
```

### DELETE USER:
```ruby
mutation {
  user: deleteUser(
    input: {
      id: "$id"
    }
    ) {
      id
    }
  }
  ```

### CREATE DISH:
```ruby
mutation {
  dish: createDish(
    input: {
      name: "Pad Thai"
      cuisineType: "Thai"
      yelpId: "123"
      spiceRating: 2
    }
  ) {
    name
    cuisineType
    yelpId
    spiceRating
  }
}
```

### UPDATE DISH:
```ruby
mutation {
  dish: updateDish(
    input: {
      id: "$id"
      name: "Super Spicy Pad Thai"
      cuisineType: "Thai"
      yelpId: "1"
      spiceRating: 9
    }
  ) {
    id
    name
    cuisineType
    yelpId
    spiceRating
  }
}
```

### DELETE DISH:
```ruby
mutation {
  dish: deleteDish(
    input: {
      id: "$id"
    }
  ) {
    id
  }
}
```

### CREATE REVIEW:
```ruby
mutation {
  review: createReview(
    input: {
      description: "yummers"
      overallRating: 4
      userId: "$user_id"
      dishId: "$dish_id"
    }
) {
    description
    overallRating
    userId
    dishId
  }
}
```

### UPDATE REVIEW:
```ruby
mutation {
  review: updateReview(
    input: {
      description: "eh, actually its not great"
      overallRating: 2
      id: "$id"
    }
) {
    description
    overallRating
    id
  }
}
```

### DELETE REVIEW:
```ruby
mutation {
  review: deleteReview(
    input: {
      id: "$id"
    }
) {
    id
  }
}
```

### Example of a graphql call to BE that will pull up a restaurant, its dishes, and all associates reviews all at once:
```ruby
{
  restaurant(id: "OT6MJNr8Gzd9nyf25dEl6g") {
    id
    name
    rating
    price
    imageUrl
    url
    categories
    address
    phone
    lat
    lon
    city
    dishes {
      id
      name
      cuisineType
      yelpId
      spiceRating
      reviews {
          id
          description
          overallRating
          userId
          dishId
      }
      }
    }
  }
```

### Here’s an endpoint for the dishes with the highest spiceRating:
```ruby
{ hottestDishes(amt: -number-) {
                id
                name
                cuisineType
                yelpId
                spiceRating
            }
          } (
```   

### 🔥 Local Setup

1. Fork and clone the repo to your local machine with SSH: `git clone git@github.com:HeatChecc/Heat-Check-BE.git`

2 .Register for external API keys:
  * [Yelp API key](https://www.yelp.com/developers/v3/manage_app)
3. Install gems and dependencies: `bundle install`
4. Configure API keys by running `bundle exec figaro install` and then adding keys to `application.yml` file:
  * yelp_token: your_key_here
5. Set up database: `rails db:{drop,create,migrate,seed}`
6. Run test suite: `bundle exec rspec`
7. Start up your local server: `rails s`
8. Visit the endpoint url  `http://localhost:3000/graphiql` to consume the API locally.


### 🔥 Contributors

### Back-End Team
* 🌶 Phillip Stewart 🌶 • [Github](https://github.com/philmarcu) • [LinkedIn](https://www.linkedin.com/in/phillip-stewart-15497183/)
* 🌶 Eli Sachs 🌶 • [Github](https://github.com/easachs) • [LinkedIn](https://www.linkedin.com/in/easachs/)
* 🌶 Gauri Joshi 🌶 • [Github](https://github.com/gaurijo) • [LinkedIn](https://www.linkedin.com/in/gaurijo/)
* 🥵 Ethan Nguyen 🥵 • [Github](https://github.com/Ethan-t-n) • [LinkedIn](https://www.linkedin.com/in/ethan-nguyen-82b398233/)

### Front-End Team
* 🌶 David Daw 🌶 • [Github](https://github.com/davidhdaw) • [LinkedIn](https://www.linkedin.com/in/david-daw-04aa36237/)
* 🌶 Ivy Nguyen 🌶 • [Github](https://github.com/INguyen22) • [LinkedIn](https://www.linkedin.com/in/ivy-nguyen-051b27212/)
* 🌶 Cleveland Ticoalu 🌶 • [Github](https://github.com/cleveland231) • [LinkedIn](https://www.linkedin.com/in/cleveland-ticoalu/)
