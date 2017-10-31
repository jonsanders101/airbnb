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
* **Testing**: Jasmine, Capybara

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
So that I know my sign-up was successful
I want to receive an email confirming my sign-up

As a host
So that I know my space has been listed
I want to receive an email confirming my listing

As a host
So that I know the updates to my space were successful
I want to receive an email confirming my updates

As a host
So that I am aware of outstanding booking requests
I want to receive an email when a guest requests to book my space

As a guest
So that I know if my booking request is successful
I want to receive an email when my host accepts my request

As a guest
So that I know if my booking request was denied
I want to receive an email when my host rejects my request

As a user
So that I can be aware of happenings on my account
I want to be able to provide a phone number upon sign-up

As a host
So that I am aware of outstanding booking requests
I want to receive a text message when a guest requests to book my space

As a guest
So that I know if my booking request is successful
I want to receive a text message when my host accepts my request

As a guest
So that I know if my booking request was denied
I want to receive a text message when my host rejects my request

As a guest
So that I can communicate efficiently with my host
I want to be able to use Makers BnB chat once my booking is confirmed

As a host
So that I can communicate efficiently with my guest
I want to be able to use Makers BnB chat once I have confirmed their request

As a guest
So that I can pay for my booking
I want to be able to use Stripe to make the payment

As a host
So that I can receive payment for my space
I want to be able to use Stripe to view the payment
````
