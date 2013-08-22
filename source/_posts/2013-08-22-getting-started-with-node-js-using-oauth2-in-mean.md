---
layout: post
title: "Getting Started with Node.js #2: Using OAuth2 in MEAN applications"
date: 2013-08-22 10:48
comments: true
categories: [Code]
tags: [mean,node.js,oauth,express,passport.js,tutorial,series]
series: Getting Started with Node.js
series_description: An introduction to MongoDB, Express, Angular, and Node.js describing how to use the MEAN stack to quickly set up fully functional web applications with Node.js. The series assume you have some programming experience.
---
Once you have an application based on [MEAN](http://xorcode.net/17N7RmC) you may want to secure the <abbr title="Application Programming Interface">API</abbr> end-points. At Xorcode we use [OAuth2](http://xorcode.net/17N7SH8) for securing <abbr title="REpresentational State Transfer">REST</abbr> API end-points. OAuth can be cumbersome for web applications, though it is perfect for native desktop and mobile applications.

<!--more-->

<p class="alert">This article would not exist if it wasn't for <strong>willwh</strong> from the <strong>#node.js</strong> channel on <a href="http://xorcode.net/17N68O4">FreeNode</a> who asked how to connect MEAN to an iOS application.</p>

In order to make this tutorial lesson easier to understand we have created a branch of MEAN which you can checkout and toy around with.

<a href="http://xorcode.net/1av99Yo" class="btn btn-info"><i class="icon-github"></i> Clone our MEAN repository</a>

In order to use OAuth2 with MEAN we first need to modify `package.json` to include the relevant Node.js modules that we need to use in order to enable support for OAuth authentication.

    "dependencies": {
      ...
      "passport-http": "latest",
      "passport-http-bearer": "latest",
      "passport-oauth2-client-password": "latest",
      "oauth2orize": "latest",
      "debug": "~0.7.2"
      ...
    }

We also added the debug module since it's used by **oauth2orize** and we decided to use the same pattern for our additions to mean.

Update the dependencies in your mean project:

    $ npm install

## Creating supporting Models

OAuth needs to store tokens somewhere so we'll create the required Mongoose schemas for use with oauth2orize and Passport.

- [app/models/oauth_client.js](https://github.com/Xorcode/mean/blob/passport-oauth/app/models/oauth_client.js)
- [app/models/access_token.js](https://github.com/Xorcode/mean/blob/passport-oauth/app/models/access_token.js)
- [app/models/request_token.js](https://github.com/Xorcode/mean/blob/passport-oauth/app/models/request_token.js)

The **OAuthClient** model serves as the foundation of this data structure. Each **AccessToken** and **RequestToken** is bound to a client and a user. When a client (web/mobile/desktop) requests permissions to access a user's data, it identifies itself with its key.

RequestTokens are used during the interchange between the client and the server as a request for an AccessToken takes place.

AccessTokens are the final result of the OAuth2 transaction. They serve as the "password" used by the client to access the user's data.

## Adding CRUD for OAuth Clients

The only part of OAuth that our application's users can directly interact with are the Clients. In Twitter and Facebook terms, these are "Applications." We have created the necessary scaffolds for you:

- [config/middlewares/authentication.js](https://github.com/Xorcode/mean/blob/passport-oauth/config/middlewares/authorization.js)
- [app/controllers/clients.js](https://github.com/Xorcode/mean/blob/passport-oauth/app/controllers/clients.js)
- [public/js/controllers/clients.js](https://github.com/Xorcode/mean/blob/passport-oauth/public/js/controllers/clients.js)
- [public/js/services/clients.js](https://github.com/Xorcode/mean/blob/passport-oauth/public/js/services/clients.js)

These controllers with their accompanying views are basic. Feel free to modify them to your needs. You may for instance want to add verification of the redirect URI by adding a `redirectUri` field to the OAuthClient schema, that way you can ensure that clients cannot be used to redirect to a site that may have nefarious intent.

We also need to modify some existing files in mean:

- [public/js/config.js](https://github.com/Xorcode/mean/blob/passport-oauth/public/js/config.js)
- [public/js/controllers/header.js](https://github.com/Xorcode/mean/blob/passport-oauth/public/js/controllers/header.js)

This will set up our client-side routes and make sure that the application responds properly when we want to edit/view clients.

- [config/routes.js](https://github.com/Xorcode/mean/blob/passport-oauth/config/routes.js)

Finally we need to add some routes to our router.

    //Client Routes
    var clients = require('../app/controllers/clients');
    app.get('/clients', clients.all);
    app.post('/clients', auth.requiresLogin, clients.create);
    app.get('/clients/:clientId', clients.show);
    app.put('/clients/:clientId', auth.requiresLogin, auth.client.hasAuthorization, clients.update);
    app.del('/clients/:clientId', auth.requiresLogin, auth.client.hasAuthorization, clients.destroy);

Once we have this up and running, we're ready to create clients.

## The OAuth2 Permissions Dialog

Once a user wants to connect to our service from somewhere -- like a mobile application -- we need to get their permission first.

- [app/views/oauth/dialog.jade](https://github.com/Xorcode/mean/blob/passport-oauth/app/views/oauth/dialog.jade)

If you are familiar with Twitter or Facebook, you know that these sites ask for your permission when you want to connect them to another site or application. We will do the same for our users.

## OAuth2 Express Middleware

In order to integrate OAuth2 into our application we need to make several modifications to existing files as well as add a few new files. First up we will modify our Passport middleware.

- [config/passport.js](https://github.com/Xorcode/mean/blob/passport-oauth/config/passport.js)

We need to add Passport strategies for basic authentication, client password authentication, and bearer authentication.

- [config/routes.js](https://github.com/Xorcode/mean/blob/passport-oauth/config/routes.js)

Once we have added the passport strategies, we need to add a few new routes to allow clients to interact with our OAuth end-points.

    var oauth2 = require('./middlewares/oauth2');
    app.get('/oauth/authorize', auth.requiresLogin, oauth2.authorization, oauth2.dialog);
    app.post('/oauth/authorize/decision', auth.requiresLogin, oauth2.server.decision());
    app.post('/oauth/token', oauth2.token);

These three new routes use our oauth2orize server.

- [config/middlewares/oauth2.js](https://github.com/Xorcode/mean/blob/passport-oauth/config/middlewares/oauth2.js)

The server definition contains definitions for grants, exchanges, and authorization hooks for Passport and Express.

## Common functionality

The OAuth2 code that we have added share some common functionality. We have added these shared methods in a file that you can drop into your project.

- [app/lib/utils.js](https://github.com/Xorcode/mean/blob/passport-oauth/app/lib/utils.js)

These methods are used by the OAuth2 key generator.

## Testing your implementation

In order to make sure that you have set everything up correctly, we recommend that you test things out locally before deploying to a server. We have supplied a very basic Express server with which you can test your implementation before you deploy to a server somewhere.

- [scripts/server.js](https://github.com/Xorcode/mean/blob/passport-oauth/scripts/server.js)

Create a new client and modify the OAuth2 configuration in `server.js` with the key and secret of your new client.

This example assumes that your main mean server runs on port 3000 and that your testing server runs on port 4000.

    $ cd scripts
    $ npm install
    $ node server.js
    listening on port 4000

Once the server's up and running you can navigate to http://localhost:4000/ to test your implementation by clicking on the "Authenticate with Service" link. Clicking the link will take you to the OAuth dialog of your main mean application. Once you click "Allow" you should be taken back to the testing server where your access token should be printed. You are now ready to use the access token through the Bearer strategy.

Our next article will explain how to secure particular parts of your application with the methods you have learned in this lesson.

{% series_list %}
