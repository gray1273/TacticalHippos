# Project 4 - Final Project

### Project Members

Ryan Bentivegna  
Nathan Gray  
Axay Patel  
Ian Thompson  
Srujan Tripathi  
Daquian Zuo 

## Description
This is a Ruby/Rails program that scrapes the publicly available course data  
from OSU's course catalog, found [here](https://registrar.osu.edu/courses/index.asp). The command for scraping the data  
and putting it into the database can be run from the command line. The data  
can be shown through the web page, which shows all the available courses and  
sections that have been entered into the database. 

A login page lets you log in or create an account for three types of users: grader,  
instructor, or admininstrator. The functionality is as follows:

### Graders
- Apply to new sections to be a grader
- View sections that you have applied to
- View sections in which you are a grader

### Instructors
- Recommend students to be a grader for a course or for a particular section
- View all sections in which you are an instructor

### Administrators
- View all sections and all courses
- Approve applications for grader positions
- Re-scrape the web page
 

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

If you would like to search the database for classes you can go to:
`http://localhost:3000/search`

## Documentation

### Routes

`/users/sign_in`: Login

`/my_sections`: Grader / Instructor home

`/all_sections`: Admin home

### Controller

Found in: `project3/courseSchedule/app/controllers/`

Contains the logic for RESTful operations on the database. Of note, in Section,  
the method `create_safely` allows the caller to pass in all parameters for child  
models as strings, and only creates a new entry if it is not a duplicate. 

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
- Recommendations
  - int id
  - int grader_id
  - int instructor_id
  - int course_id
  - int section_id
  - int recommendation_type
  - string message


### View

Found in: `/project3/courseSchedule/app/views/`

Contains all the pages that allow the user to view the data.

- Search: Allows users to see all current courses entered in the database
- Login: Allows users to log in
- Grader home: Allows graders to apply for sections, see which sections they have applied to, and see which they have been accepted for
- Instructor home: Allows instructors to see which sections they are teaching and to make recommendations
- Administrator home: Allows administrators to accept applications and re-scrape
