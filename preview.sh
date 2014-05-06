#!/bin/sh
rm -Rf source/_layouts source/_assets && bundle exec rake update_source[xorcode] && rm -Rf source.old && rm -Rf public && bundle exec rake preview
