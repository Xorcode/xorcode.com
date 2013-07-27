---
layout: post
title: "Web Servers in AWS: Performance Tune Apache 2.x"
description: "Performance Tune Apache 2.x"
categories: [Cloud,Server]
excerpt: Help determine your Apache ServerLimit and MaxClients for your specific server configuration.
tags: [aws,amazon,apache,performance]
---

Help determine your Apache `ServerLimit` and `MaxClients` for your specific server configuration.

Oftentimes when we fire up a new AWS instance we use the t1.micro type. The default Apache configuration does not take this into account. The t1.micro instances also come without a swap partition which may cause trouble once your instance run out of RAM. If you are running MySQL or memcached on the same server you will sooner or later notice that MySQL has stopped responding because the operating system killed it.

Use the following simple script to determine your Apache `ServerLimit` and `MaxClients`:

{% gist 4496984/check-apache-instances.sh %}

The script will output something similar to this:

{% gist 4496984/shell-output.txt %}

You would then modify your Apache configuration accordingly:

{% gist 4496984/httpd.conf %}

The above configuration excerpt assumes that you are using `mod_prefork` and that you want to keep some free RAM for other processes such as MySQL.
