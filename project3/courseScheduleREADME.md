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

`$ ruby Scraper.rb`

### Running the Program

In a browser, go to:

`http://localhost:3000`

and the login page will be shown, which will redirect to the home page.


## Documentation

### Controller

Found in: `project3/courseSchedule/app/controllers/`

### Model

Found in: `/project3/courseSchedule/app/models/`

### View

Found in: `/project3/courseSchedule/app/views/`
