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
$ annote w+ tags convolutional neural network CNN classification ./very_interesting_article.pdf
Attribute "tags" set to 47 byte value for ./very_interesting_article.pdf
convolutional neural network CNN classification
~~~

Search library for previously annotated documents
~~~
$ annote search tags CNN
# file: very_interesting_article.pdf
user.tags"convolutoinal neural netowrk CNN classification"

~~~

Append to and remove existing attributes from documents
~~~
$ annote a+ tags machine learning ./very_interesting_article.pdf
Attribute "tags" set to a 64 byte value for ./very_interesting_article.pdf
convolutional neural network CNN classification machine learning

$ annote rm tags ./very_interesting_article.pdf
~~~


