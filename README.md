# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


# Rails stuff

```
rails generate migration add_checkout_ref_to_checkout_items checkout_items:references
```
rake db:drop db:create db:migrate

http post :3000/items price=2.95 description=eggs is_exempt=false upc=12345
http post :3000/members name="Jeff Langr" phone=719-287-4335 discount=0.02

http post :3000/checkouts
http post :3000/checkouts/1/scan/12345
http get :3000/checkouts/1/total
http post :3000/checkouts/1/scan_member/719-287-4335

bundle exec rspec

