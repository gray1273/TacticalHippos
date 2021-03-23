# Project 3 - Web Scraping and Login

This is a Ruby/Rails program that scrapes the publicly available course data  
from OSU's course catalog, found [here](https://registrar.osu.edu/courses/index.asp). The command for scraping the data  
and putting it into the database can be run from the command line. The data  
can be shown through the web page, which shows all the available courses and  
sections that have been entered into the database. In addition, a login page is  
available.

### Project Members

Ryan Bentivegna  
Nathan Gray  
Axay Patel  
Ian Thompson  
Srujan Tripathi  
Daquian Zuo  

## Setup

### Database Startup

`$ bundle install`  
`$ rails db:migrate RAILS_ENV=development`  
`$ rails server`  

### Web Scraping and Login

`$ cd courseSchedule/app`
`$ rails runner Scraper.rb`

### Running the Program

In a browser, go to:

`http://localhost:3000`

and the login page will be shown, which will redirect to the home page.


## Documentation

### Controller

Found in: `project3/courseSchedule/app/controllers/`

Contains the logic for RESTful operations on the database. 

### Model

Found in: `/project3/courseSchedule/app/models/`

Contains representations of each table in the database. The tables include:
- User
  - int id
  - int user_type_id
  - string first_name
  - string last_name
  - string email
- User Type
  - int id
  - string title (Student, Instructor, Admin)
- Course
  - int id
  - int catalog_number
  - string title
  - string description
- Section
  - int id
  - int course_id
  - int instructor_id
  - int section_type_id
  - int term_id
  - int instructionMode_id
  - int location_id
  - int section_number
  - int class_number
  - date start_date
  - date end_date
  - string days_of_week
  - time start_time
  - time end_time
- Section Type
  - int id
  - string type (Lab, Lecture)
- Term
  - int id
  - int season_id
  - int year (2020, 2021)
- Season
  - int id
  - string title (Spring, Summer, Autumn, Winter)
- InstructionMode
  - int id
  - string mode (Online, In-Person)
- Location
  - int id
  - string location (Online, a classroom)
- Grader_Section
  - int id
  - int user_id
  - int section_id

### View

Found in: `/project3/courseSchedule/app/views/`

Contains all the pages that allow the user to view the data.

- Search: Allows users to see all current courses entered in the database
- Login: Allows users too log in
