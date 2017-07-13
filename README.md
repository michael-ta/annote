# Annote
Use extended attributes to organize downloaded research articles and other publications

## Installation
Requires attr and getfattr to manage and query extended file attributes

~~~
$ apt-get install attr
~~~

Set $LIBRARY to the location of the articles/documents to annotate and search

## Usage
Sets the user.tags attribute with the supplied arugments on a given file
~~~
> annote w+ tags convolutional neural network CNN classification ./very_interesting_article.pdf
~~~

Search library for previously annotated documents
~~~
> annote search tags CNN
# file: very_interesting_article.pdf
user.tags"convolutoinal neural netowrk CNN classification"

~~~


