# Makers BnB

Our task is to make a clone of Air B'n'B.

## Authors

* Canace Wong
* Lucy Borthwick
* Aram Simonian
* Ed Lowther
* David Halewood
* Jon Sanders

## Technologies Used

* **Front-end**: HTML, CSS
* **Server-side**: Ruby, Sinatra
* **Database**: PostgreSQL
* **ORM**: DataMapper
* **Testing**: RSPEC, Capybara

## How to use Makers BnB

To use this website start by cloning this repository to your local machine and running bundle in your command line.
````
git clone git@github.com:jonsanders101/airbnb.git
bundle
````

Once you have done this, run 'rackup' in your command line and you can explore the website as you please!

### How to use Twilio

In order to benefit from the messaging functionality we have created on our website, you will need to sign up for a Twilio trial account. Once you have done this, you will be provided with an 'Account SID', an 'authorisation token' and a 'Twilio number'. You will need to store these as environment variables on your machine. You can do this by running the following commands in your terminal, replacing the dummy strings with your account credentials.

````
export account_sid=ACxxxxxxxxxxxxxxxxxxxxxxxx
export auth_token=yyyyyyyyyyyyyyyyyyyyyyyyy
export twilio_number=+12121234567
````
Once you have done this, restart your terminal and you're ready to start receiving text notifications!

## User Stories

### MVP

The following user stories define our MVP.

```
As a user
So that I can use Makers BnB
I need to be able to sign up for an account

As a host
So that I can rent out my space
I need to be able to list it

As a potential guest
So that I find somewhere to stay
I need to be able to view all listings

As a host
So that I maximise revenue
I need to be able to list more than one space

As a host
So that I can attract guests
I need to be able to give my space a name

As a host
So that I can attract guests
I need to be able to give a short description of the space

As a host
So that I can inform guests
I need to be able to give a price for staying in the space

As a host
So that I can inform guests
I need to be able to indicate the space's availability

As a guest
So that I can book a short trip
I need to be able to request an available space for one night

As a host
So that I can control who stays in my space
I need to be able to approve requests

As a guest
So I am not left without accommodation
I need to know when space have already been booked

As a host
So I can control who stays in my space
I want the space to remain available until I've confirmed a guest
````

### Additional functionality

The following user stories define the additional functionality we added once we had completed our MVP.

````
As a user
So that I can be aware of happenings on my account
I want to be able to provide a phone number for my account

As a guest
So that I know if my booking request is successful
I want to receive a text message when my host accepts my request

As a guest
So that I know if my booking request was denied
I want to receive a text message when my host rejects my request
````
