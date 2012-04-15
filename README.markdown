# Nations' Service

This site is being developed so that it can be used as a free, collaborative resource for university
students and alumni to explore a wide variety of career paths together, and to discuss alternatives
to the seemingly limited options students see as they approach graduation.
If you have some ideas to share and want to help add to the site, visit our [current site](http://nationsservice.org).
There we have developed a rough version of the site on the Wikidot engine to get the project off the ground quickly.
But now, as we are expanding and looking to add new features to enhance user experience, we have decided to build a
new version with rails. If you'd like to become a maintainer, please let me know.

## Data Model Description

There are currently six models:

* User - users of the site
* Position - a fellowship, internship, job or other
* Locale - geographic location associated with a set of positions
* Institution - college or university in the US
* Campus - a campus that is a subset of some institution
* Placement - the placement of a position in a locale

## Data Sources

The list of U.S. institutions used here is provided by [The University of Texas as Austin](http://www.utexas.edu/world/univ/state/).