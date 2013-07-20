require 'cgi'

module Xorcode
  module Liquid
    class QrCodeTag < ::Liquid::Tag
      def initialize(tag_name, id, tokens)
        @url = "https://market.android.com/details?id=#{id.strip}"
        super
      end

      def render(context)
        img_uri = "https://chart.googleapis.com/chart?cht=qr&chs=150x150&chl=#{CGI.escape(@url)}&choe=UTF-8&chld=M|0"
        <<MARKUP.strip
<p><a href="#{@url}"><img src="#{img_uri}"></a></p>
<p><a href="#{@url}" class="btn btn-large btn-primary">Download from Android Market</a></p>
MARKUP
      end
    end
  end
end

Liquid::Template.register_tag('qr', Xorcode::Liquid::QrCodeTag)
