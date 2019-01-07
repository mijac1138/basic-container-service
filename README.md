# Basic Container Service

Proof of concept application for returning HTML fragments built with [Roda](https://github.com/jeremyevans/roda/blob/master/README.rdoc).

### Install dependencies
    $ bundle install

### Serve application
    $ rackup

### To test application send GET request (ie in Postman)
    http://localhost:9292/service/table
    or
    http://localhost:9292/service/list

    with Header:
    TOKEN: 'SOME-TOKEN' # would be token sent by Stacker
