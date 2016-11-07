# Junior Project
It was my junior project in the third year of studying. 
Main idea was to help people finding movies based on their preferences without
spending too much time looking here and there. Read more on the paper.


## What's done in this project
By that time I wanted to learn more about Ruby and Ruby on Rails. So I would
learn more about them while creating the project. 

* I have used data provided by IMDB [at this
  location](http://www.imdb.com/interfaces)
* In order to parse and move the data into database, I have used
  [IMDbPY](http://imdbpy.sourceforge.net/)
* I was just able to get release dates and movie title, so I have used [OMDb
  API](https://www.omdbapi.com/) to populate the database with missing part.
* I have wrote scripts in Python and Ruby to have a decent dataset.
* I have used bootstrap, jquery and ajax call to have a more responsive
  interface.
* I have written some Ruby tasks to find similarities between movies and users,
  also to implement some algorithms to improve the recommendation engine.
* I have used heroku for demo purposes.

## Outcome
I had been a great experience that taught me a lot about Ruby, Rails, Heroku, git,
MySQL and PostgreSQL, and general recommendation system.

## To-Dos
* user can just view his own page, route to profile
* learn about backing up and restore database
* show movies when clicked on a language/genre/director etc
* create a task to delete entries from search table
* Improve search module
* improve movie similarities, create vector of each movie
* pull movie from db and check if it has at least 10 similar movies, if not
  find similar movies. also show random 4 movies
* navbar, movie show, and movie pin are not mobile compatiable
* when logging in to leave comment, redirect user back to same page!!

## Admin 
* Delete users, comments, see the system variables
* Add an admin in seeds

X add comment edit, delete functionality
X add all movies instead of just 250 list
X deploy to heroku
X Remove users index page[just admin can view this page]
X remove a movie from watchlist when added to watchedlist
  [A movie can stay in watchlist, even it was watched]
X add user rated movies page
X show feedback message after adding/removing a movie to/from watchlist.
  [NO need for feedback, button changes already]
X Fix movie/show title. long movie titles doesnt fit!!
X add comment functionality
X add searching capabilities
X add stats like 'has in his favorite list' or 'watches list' for each movie
X use ajax calls while adding/removing movies to list
X Fix imdb votes number, put dots or commas
X 3.5/10 (10) amr rating system
X Pluralize director/actor/writers on movie show page
