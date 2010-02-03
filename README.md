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
* Photos have titles and descriptions
* Members can leave comments on photos
* Activity log shows entries for album creation, photo uploads and comments
* Time zones and i18n (currently English and Russian) are supported

What's Planned
==============

So far I plan to add only:

* RSS feed for the activity log
* Email notifications
* Member mini-blogs

Requirements
============

* Rails 2.3.5 (other 2.x versions untested and may work)
* All other gems vendored

Installation
============

1. Download the source:

		git clone http://github.com/alg/family_hut.git

2. Bundle gems:

		gem bundle
		
3. Copy the database config from `config/database.yml.sample` to `config/database.yml`
	 and update as appropriate.

4. Setup the app:

		rake db:setup

The first user will be named `first` and will have password `first`. You can rename
it as you like and start inviting other members.

License
=======

Family Hut is Copyright © 2010 [Aleksey Gureiev](mailto:spyromus@noizeramp.com).
It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.