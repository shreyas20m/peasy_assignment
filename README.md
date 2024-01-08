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



ruby -> 3.3.0 

rails -> 7.1.2

start sidekiq bundle exec sidekiq -q create_user_job -c 1 -C config/sidekiq_config/create_user_job.yml

bundle exec sidekiq -q daily_record_job -c 1 -C config/sidekiq_config/daily_record_job.yml

I faced issues for Liquid, so I used rails for UI