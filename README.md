# Bike Share

![alt text](https://i.imgur.com/4WnR2K7.jpg)

### Abstract

Using Ruby, Rails, and ActiveRecord, this project analyzes the Greater Bay Area's bike share program data.  It explores general statistics of bike trips and stations. It also explores usage statistics between stations and bikes docked, stations and other stations, and bike trips and weather data.  

A bike shop was also created where visitors can browse bike accessories and add them to a shopping cart.  Visitors can register for an account in order to login and checkout the accessories in their cart.

### Configuration
* Step 1: Clone this repository

 ```
 git clone https://github.com/sdmalek44/spoke
 ```

* Step 2: Install gems
```ruby
$ bundle install
$ bundle update
```
Gems Included: Capybara, Database Cleaner, Shoulda Matchers, Pry, Launchy, SimpleCov, Bootstrap

Step 3: Setup the database

```
$ rake db:{drop,create,migrate,install}
```

Step 4: Run the test suite

```
$ rspec
```

### Usage

Visit [spoke-share.herokuapp.com/](http://spoke-share.herokuapp.com/) hosted on Heroku.  

From the homepage, you can login, create an account, visit the bike shop, or view any list of stations, trips, or weather conditions included in the data.

Once you create an account and login, you will have access to the dashboards for usage statistics related to stations, trips, and weather conditions.

### Indexes

There are indexes for stations, bike trips, and weather conditions that contain full lists of data.  These indexes are all accessible from the homepage via the navigation bar at the top of the screen.  From any index, you can click on any line item to take you to a page with detailed information about the item.

### Bike Shop

There is a link to the bike shop in the navigation bar.  On the bike shop page, you can browse products for sale.  If an accessory has been retired, you will see that the add to cart button is not accessible.  You can add and remove items to your cart at will, but to checkout, you will need to log in.

### Dashboards

Once you log in, you will have access to dashboards with aggregated statistics for stations, bike trips, and trips given various weather conditions.

### Contact Information

Feel free to contact us with any questions, comments, or suggestions:
* Colin: [https://github.com/colinwarmstrong](https://github.com/colinwarmstrong)
* Stephen: [https://github.com/sdmalek44](https://github.com/sdmalek44)
* Matt: [https://github.com/wehttamclan](https://github.com/wehttamclan)
