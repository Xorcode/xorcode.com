require "uglifier"

Uglifier::DEFAULTS[:output][:comments] = :none

require "jekyll-assets"
require "sprockets-less"
