# Little Esty Shop

## Background and Description

"Little Esty Shop" is a group project that requires students to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.

## Learning Goals
- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- [Optional] Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

## Requirements
- Must use Rails 7.0.x, Ruby 3.2.2
- Must use PostgreSQL
- All code must be tested via feature tests and model tests, respectively
- Must use GitHub branching, team code reviews via GitHub PR comments, and either GitHub Projects or a project management tool of your group's choice (Trello, Notion, etc.)
- Must include a thorough README to describe the project
   - README should include a basic description of the project, a summary of the work completed, and some ideas for a potential contributor to work on/refactor next. Also include the names and GitHub links of all student contributors on your project. 
- Must deploy completed code to the internet (using Heroku or Render)
- Continuous Integration / Continuous Deployment is not allowed
- Use of scaffolding is not allowed
- Any gems added to the project must be approved by an instructor
  - Pre-approved gems are `capybara, pry, faker, factory_bot_rails, orderly, simplecov, shoulda-matchers, launchy`

## Setup

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## Phases

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md)


## Readme
#### Project Description
This project has been a container of different areas of education through Turing, including the use and organization of CSV files and converting them into smart objects for more dynamic assessments. It has required some new skills to develop including Rake, FactoryBot, Faker, CSS, HTML styling, and more.

The project is split into different phases:
- Phase 1 - CSV loading through Rake and creating foreign key relationships
- Phase 2 - Setting up Factory Bot and Faker to more efficiently instantiate test objects
- Phase 3 - Following User Stories and ensuring the standards of MVC
- Phase 4 - Formatting and Styling by matching the view to the provided wireframes
- Phase 5 - Refactoring for DRY methods with the use of partials, advanced routing methods, and collaborating with one another to ensure all requirements were met

This was all while managing the project with multiple parties through the use of Github Projects and communication through Slack.

All-in-all, this project has been a great practice of collaboration, managing complex Github merge conflicts, and tying in new and old DRY/MVC practices for better technical understanding.
  
#### Summary of Work Completed 
  - All user stories up to extension 1 was completed, styling
  - Partial completion of extension 1-2
  
#### Potential Refactor
- Update the path for all tests (i.e. from /merchants/:merchant_id/dashboard to merchant_dashboard_index_path)
- Refactor to build helper methods in controllers
- Use iteration for some of the tests
  
#### Contributors
- Anthea Yur: https://github.com/chisPmama
- Joseph Lee: https://github.com/josephlee702
- Nathan Trautenberg: https://github.com/WagglyDessert
- Sooyung Kim: https://github.com/skim1027

