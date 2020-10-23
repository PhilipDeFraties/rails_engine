# Rails Engine
Rails Engine is a project in which an internal API has been built to provide specific endpoints to search for merchants and their items.

This is the base repo for the [rails engine project](https://github.com/PhilipDeFraties/rails_engine) used for Turing's Backend Module 3.

# About this Project  

## Contributors
[Philip DeFraties](https://github.com/PhilipDeFraties)  

## Installation
Rails engine works with a separate programs called Rails driver with a spec harness that tests its capabilities. Both will need to be cloned into a directory in order for the spec harness in rails driver to utilize rails engine.

```
git clone https://github.com/PhilipDeFraties/rails_engine
git clone git@github.com:PhilipDeFraties/rails_driver.git
```

## Dev Environment Setup
Next you're going to want to run these commands from your terminal's command line just to get everything set up:

```
cd rails_engine
bundle install
bundle update
rake db:create
rake db:migrate
rake db:seed
```

## Usage
Activate rails engine as a local server from within the rails engine home directory
```
rails s
```
To run the spec harness, from a different tab in the console cd into the driver home directory
```
bundle exec rspec
```

## Gems Being Utilized
Here are the more relevant gems we've added to the base rails gems to make this app really sing:

```
gem 'factory_bot_rails'
gem 'rack-cors'
gem 'faraday'
gem 'webmock'
gem 'vcr'
gem "figaro"
gem 'travis'
gem "nyan-cat-formatter"
gem 'fast_jsonapi'
```  

## Schema
Below is our schema.

![schema](https://dbdiagram.io/d/5f92f3f33a78976d7b78ea77)

## Learning Goals
For this project, we focused on learning:
 - Building an internal API with rest endpoints

## Future Changes
- Full test coverage for models
- Additional endpoints for business intel section of spec harness

## Code We're Proud Of

## Versions

- Ruby 2.5.3	- Ruby 2.5.3

- Rails 5.2.4.3	- Rails 5.2.4.3

2020-10-15: v 1.0
