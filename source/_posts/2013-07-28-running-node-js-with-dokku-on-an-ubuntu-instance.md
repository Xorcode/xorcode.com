---
layout: post
title: "AWS PaaS: Running Node.js with Dokku on an Ubuntu instance"
date: 2013-07-28 11:48
comments: true
categories: [Cloud,Server]
tags: [node.js,dokku,docker,ubuntu,paas]
---
After having tried several fully featured PaaS stacks such as [Nodejitsu](https://www.nodejitsu.com/), [Heroku](https://www.heroku.com/), and [OpenShift](https://www.openshift.com/) we decided to roll our own simple PaaS stack with [Dokku](https://github.com/progrium/dokku) and [AWS](http://aws.amazon.com/).

<!--more-->

During our initial testing we started out with a `t1.micro` instance, which seemed sufficient for development needs. The instance consumes a constant 100% CPU during operation, yet the different services respond in a timely fashion with a few megabytes of RAM to spare with two to three applications running. Definitely not the configuration we would use for a production environment.

