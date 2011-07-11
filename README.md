##Summary

Storyboard is a simple Web application for agile project management. 

It was built primarily as a learning exercise and would need further
work to be production ready.

##Technology

Storyboard is a Rails 3.0 application and uses MongoDB as its backend
datastore. It uses Haml instead of ERB for view templates, jQuery in
place of prototype.js and Mongoid in place of Active Record.

##Tests

Tests are written in RSpec and I have used Autotest to do continuous
testing:

    % bundle exec autotest

Most of the model classes are reasonably well covered. Elsewhere the
tests are more patchy. I have started using Capybara for Request specs.

##Sample data

To aid manual testing there is a db/seeds.rb file containing a small set
of sample data which can be applied to the development database:

    % rake db:seed

##Authentication

Storyboard uses a home-grown authentication mechanism and cancan for
authorisation rules. The basic rule is that anybody can read information
about the state of a product but you have to log in to make any changes.

The seed data comes with a number of built-in users: Bob, Derek, Mary,
Alice and Norman, each of which has password ''secret''.

##Agile methodologies

Storyboard is loosely based on a Scrum-like process that I have used at work, not that
I am endorsing Scrum (or any other methodology) here. 

The system can manage multiple Projects, each of which has multiple
Releases. Within a Release you can have any number of Sprints.

For each project there is a Backlog of Stories, which can be prioritised
and eventually committed to a Sprint.

Once a Story is committed to a Sprint, Tasks can be defined as part of
the detailed Sprint planning and assigned to team members. Team members
can view a taskboard to visualise the state of the Tasks in the current
Sprint.

There are views for Sprint and Release that include graphical burndown
and velocity charts.

##Compatibility

During development Storyboard has been run on OSX and with Safari,
Chrome and Firefox browsers. To date it has not been run on other
platforms.

##Roadmap

A few of the areas that need attention:

* Design/Styling.
* Forms - generally these are little better than scaffold forms at the
  moment.
* More comprehensive request specs.
* Limit read-only access to logged on users.
* The Administration tab is not implemented - this is meant to allow a
  privileged user to manage users and teams.
* Return real data for the burndown and velocity charts. For burndown
  charts this will require some kind of background processing to collect
data periodically.
* Navigation - there is currently no navigation logic to take you to the
  page that you might expect after closing a page or submitting a form.
