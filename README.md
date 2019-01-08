# Basic Container Service

Proof of concept application for returning HTML fragments built with [Roda](https://github.com/jeremyevans/roda/blob/master/README.rdoc).

### Install dependencies
    $ bundle install

### Serve application
    $ rackup

### Test application

Use application like Postman to send requests and run BORG locally.
Create .env file (example included)

    BORG_JWT_AUTH_URL=*This must be BORG path: BASE_URL/stacker/authentication/authenticate*
    JWT_SECRET_KEY=*must be the same one used to create JWT token in BORG*

To get token send POST request:

    http://localhost:9292/service/authenticate

    with Form Parameters: email, password, yubikey

To get HTML fragment send GET request:

    http://localhost:9292/service/fragment/list
    or
    http://localhost:9292/service/fragment/table

    with Header:
    Authorization: Bearer <token> # token returned by http://localhost:9292/service/authenticate
