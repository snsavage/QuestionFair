# QuestionFair.com

QuestionFair.com is a website for asking questions and getting answers.  The website includes a few more advanced features including location tagging, points rewards and friendships  with other users.

QuestionFair.com was originally created as a final academic project for completion of a Master's degree in Information Systems.  QuestionFair was built using the Ruby on Rails website framework.  The site was launched March 2015, but is currently dormant and undergoing improvement for a future relaunch.  


## Project Status
QuestionFair.com is currently undergoing redevelopment.  As noted above, the website was originally created as a graduate school project.  The code represents a fully functioning, full featured website; however, the code is messy, unorganized, untested and in need of some serious refactoring.  Please check back for regular updates.  

## Setup
Follow these steps to test QuestionFair.com on your local machine. 

You will need the following software:

* Git
* Ruby v2.2.0
* PostgreSQL

Start by downloading the QuestionFair repo from GitHub and switching to the new directory:

```
$ git clone https://github.com/snsavage/QuestionFair.git
$ cd QuestionFair
```

QuestionFair uses Ruby version 2.2.0.  Installation instructions can be found here: [https://www.ruby-lang.org/en/documentation/installation/](https://www.ruby-lang.org/en/documentation/installation/).  You can check your Ruby version with:

```
$ ruby --version
```

If you have not used Ruby before install the Bundler gem.  Bundler will manage the Ruby gems used with QuestionFair.

```
$ gem install bundler
```

Before using Bunlder to install the required gems, make sure that the PostgreSQL database is installed.  PostgreSQL installation instructions can be found here: [http://www.postgresql.org/download/](http://www.postgresql.org/download/).

Run Bundler to install required Ruby gems.

```
$ bundle install
```

QuestionFair uses the dotenv gem to manage environmental variables.  These variables are primarily API keys for external services.  An example ```.env``` file is provided for reference.  This file needs to be copied before starting the server.  

```
$ cp .env.example .env
```

In order to work with QuestionFair's full functionality in a production or staging environment, the following API keys are required:

* Mandrill
* Codeclimate
* Mailchimp
* Google Geocode API
* Facebook

The site should still function without these keys in a local development environment.  However, functionality using external APIs may be limited. 

Now the database can be setup.  

```
$ rake db:create
$ rake db:migrate
```

And finally the development server can be started.

```
$ rails server
```

## Testing
QuestionFair uses the Rspec testing library.  A limited test suite is provided and additional tests will be added as the site is refactored.  Run the tests with the rspec command.

```
$ rspec
```

---

Copyright 2015 Scott Savage





