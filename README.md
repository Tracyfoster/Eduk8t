# EDUK8T API

This is the backend app that powers EduK8t's learning platform.
It is built with Rails 6.1.4

## Prerequisites

This project requires:

- Ruby 3.0.2, preferably managed using rbenv
- PostgreSQL must be installed and accepting connections


## Getting started

### With bin/setup

Run the `bin/setup` script. This script will:

- Check you have the required Ruby version
- Install gems using Bundler
- Create, migrate

### Run it!

1. Run `bundle exec rspec` to make sure everything works.
4. Run `bin/rails server`

## API Documentation
Access with [Postman](https://www.getpostman.com/collections/cdc963a1bd643dc73bd2)
### Users
User related endpoints
  * GET /api/users
  * GET /api/users/:user_id
  * GET /api/users/:user_id/eligible_courses
  * GET /api/users/:user_id/my_courses
  * POST /api/users
  * POST /api/users/:user_id/assign_course
  * PATCH /api/users/:user_id
  * DELETE /api/users/:user_id

### Authors
Author related endpoints
  * GET /api/authors
  * GET /api/authors/:author_id
  * POST /api/authors
  * PATCH /api/authors/:author_id
  * DELETE /api/authors/:author_id

### Courses
Course related endpoints
  * GET /api/courses
  * GET /api/courses/:course_id
  * POST /api/courses
  * PATCH /api/courses/:course_id
  * DELETE /api/courses/:course_id

