# Copied from https://github.com/ldesgrange/jekyll-gravatar-filter
# Copyright https://github.com/Idesgrange
# Licensed under GNU GPL v3

require 'digest/md5'

module Jekyll
  module GravatarFilter
    def gravatar(input)
      "http://www.gravatar.com/avatar/#{hash(input)}"
    end

    def secure_gravatar(input)
      "https://secure.gravatar.com/avatar/#{hash(input)}"
    end

    private :hash

    def hash(email)
      email_address = email ? email.downcase.strip : ''
      Digest::MD5.hexdigest(email_address)
    end
  end
end

Liquid::Template.register_filter(Jekyll::GravatarFilter)
