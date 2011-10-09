General
=======

Family Hut is a simple application for those who want to share information among
family members. The goal is to have a mini-social networking site mainly for
photo exchange and archiving, but also for textual info and notes.

Features
========

* Member accounts
* Members can invite other members by creating accounts for them
* Members have named photo albums
* Photo albums can contain any number of photos
* Photos can be uploaded one at a time or in bulk (up to 10 at a time)
* Easy photo uploads via AJAX without page reloads
* Photos have titles and descriptions
* Members can leave comments on photos
* Activity log shows entries for album creation, photo uploads and comments
* Time zones and i18n (currently English and Russian) are supported
* Collective blog with a feature to delete your own posts that are up to one hour old
* Summarized e-mail notifications (once every 2 hours)

What's Planned
==============

So far I plan to add only:

* RSS feed for the activity log
* Hide posts over time (and have "show older" JS button that loads 10 more older posts)
* Guest accounts with access to selected albums

Requirements
============

* Rails 3.1   
* ImageMagick

Installation
============

1. Download the source:

		git clone http://github.com/alg/family_hut.git

2. Copy and update config files:
  * config/database.yml.sample -> config/database.yml
  * config/config.yml.sample -> config/config.yml
  * config/environments/production.yml.sample -> config/environments/production.yml
  * config/deploy.yml.sample -> config/deploy.yml

3. Setup the app:

		rake db:setup

The first user will be named `first` and will have password `first`. You can rename
it as you like and start inviting other members.

License
=======

Family Hut is Copyright © 2010-2011 [Aleksey Gureiev](mailto:spyromus@noizeramp.com).
It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.