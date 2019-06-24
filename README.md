![Travis build status](https://travis-ci.org/plato721/denver-meetings.svg?branch=master)

### Personal Project - Denver Meetings

#### Links

* [Production](http://denvermeetings.org)

#### Description

"The goal of this project is to create a successful web application from a project idea. You will create an app that will authenticate with a third-party service, consume an api, and solve an actual problem." I chose to do a mobile alcoholics anonymous meeting finder for the Denver metro area.

#### My synopsis

This project is very close to my heart. It's something I've wanted to do for a long time, but I didn't have the skills/time until now. The application scrapes the 1000+ meetings listed on [www.daccaa.org](http://www.daccaa.org), parses them, and stores them with latitude and longitude obtained via the geocoder gem. It enables searching on many different criteria, like language, accessibility, gender, as well as meeting time and day. An important feature to me, and one that proved difficult to implement, was a "hot button" to show a user the closest meetings to them at the present time.

I got my feet wet with geolocating and jQuery in this project, as well as applying separate styles/scripts to different parts of the application. (Eventually there will be a desktop view, and the administrative back end is desktop-oriented.)

There are many different types of people who would benefit from an application like this.. There are those who have been sober many years but are unfamiliar with the area. There are those who are still drinking who want to see if there might be another way. But in the design exercise, I decided to create it for a woman in the first three months of her sobriety.

My user is a professional who is very good at her job when she shows up to it. The picture I drew of her for the design exercise showed her dressed up for work slumped on a bench at a bus stop. She's coming home early, because she got fired. A month or two of sobriety wasn't enough to reverse a cycle that was already in motion. She knows full well that a drink won't help the situation, but wants one anyway. She knows that a meeting might help and they're starting to become habit. Her phone is in her hand in the picture, and I hope my application helps make her day a bit brighter.

#### Building

API Keys. You're going to need some. Get a google maps API key for client-side and server-side. You can make use of Figaro to set the environment variables referenced by the app-- change sample_application.yml to application.yml and follow instructions in Figaro docs to set environment variables
from the file in production. Do not check application.yml into a public repo.
