# Human Power

Human Power lets you write your robots.txt in plain Ruby and force the robots into submission!

![Bingbot getting taught](http://i.imgur.com/77WVSQH.jpg)

**This gem is under initial development and is not released yet.**

## Installation

Add this line to your application's Gemfile:

    gem 'human_power'

Then run:

    $ bundle

Or install it yourself:

    $ gem install human_power

## Usage

### Using in Ruby on Rails

In *config/robots.rb*:

```ruby
# Disallow everything in /admin for all user agents
disallow_tree admin_path

# Googlebot
googlebot do
  disallow reviews_path # Disallow a URL
  disallow new_product_path, new_category_path # Disallow multiple paths in one line
end

# Bingbot
bingbot do
  disallow :all # There you go, Bingbot! (Disallow everything)
end

# Identical settings for multiple user agents
user_agent [:bingbot, :googlebot] do
  disallow login_path
end

# You have access to everything from your ApplicationController
if request.subdomains.first == "api"
  disallow :all
end
```

## Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new pull request
