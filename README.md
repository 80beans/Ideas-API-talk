# TDD Rails API

Learn how to make a functional but simple API for your iOS app using Rails.
We will cover creating a simple UI and a JSON based API using Test Driven Development practices
and help you get started on your own machine.
At the end of this session we will have deployed our first working app to Heroku.  
We will be using:

* TDD (Test Driven Development)
* Rails
* Heroku (cloud hosting)

You all followed this [install guide](http://guides.railsgirls.com/install/)
to bring Rails to your machine.


# Let's see where we stand

Whom of you knows:

* Rails
* Rspec
* git

Whom of you has an app running that uses any of the above?


## Rails-MVC

Both frameworks make use of the Model View Control paradigm,
but there are differences in how they are applied.
By default,
Rails controllers manage a model collection,
giving access to REST actions to manipulate that collection.


## Get the Right Rails Stack

To quickly set up a rails stack with all the dependencies
we are going to use today,
we will be using railswizard.org.

NOTE:
  If you do not have an editor with ruby support,
  please use something like [Sublime](http://www.sublimetext.com).

We even created a template for you,
so we do not run into any surprises.

Open up a terminal and navigate to the directory where you would like
the code base for this Guru session to live.
I would go to my code folder, like so:

    cd ~/code

If you are happy about the parent folder you have picked,
command the terminal to:

    rails new ideas -m http://railswizard.org/0f86db6ac27b2dfce9c9.rb -T

Then select the following options:

    heroku  Automatically create appname.heroku.com? (y/n) n


We do not want to push our app to Heroku yet,
because we all use the same name,
and we do not have much of an app to push yet.

    recipe  Running ActiveRecord recipe...
    question  Which database are you using?
    1)  MySQL
    2)  Oracle
    3)  PostgreSQL
    4)  SQLite
    5)  Frontbase
    6)  IBM DB
    activerecord  Enter your selection: 4
    activerecord  Automatically create database with default configuration? (y/n) y

We use SQLite because that is shipped with the install guide
we have just followed.
Now everyone has a folder called `ideas` in their directory of choice.
We are ready to code!


## TDD / What do we want?

To keep things simple,
we want an app in which we could input an **idea**,
consisting of a _name_ and a _description_.
Rails offers us a convenient method to quickly generate a scaffold,
which will take care of most of the acceptance spec.

    rails generate scaffold NAME [field[:type][:index] field[:type][:index]] [options]

in this case:

    rails generate scaffold idea name:string:unique description:text

The thing we need to do now is **describe** what we want.


### What we want

* List our Ideas
* Show a single idea
* Add ideas
* Edit and update our ideas
* Remove bad ideas

All this, using json connected to, say:

    localhost:3000/api/v1/ideas


### How do we tell Rspec what we want?

    describe "addition" do
      subject { 1 + something }

      context "something being 1" do
        let(:something) { 1 }

        it { should  == 2 }
      end

      context "something being -1" do
        let(:something) { -1 }

        it { should == 0 }
      end
    end

Great,
we've just tested if addition is implemented correctly in ruby.

Now for something more in line with todays challenge:

  describe "api/v1" do
    it "fetches all the ideas" do
      get ideas_api_uri
      response.body.should == <INSERT THE JSON RESPONSE OF OUR DREAMS HERE>
    end
  end
