module Jekyll

  class SeriesTag < Liquid::Tag
    def initialize(tag_name, params, tokens)
      super
    end

    def render(context)
      site = context.registers[:site]
      page_data = context.environments.first["page"]
      series_name = page_data['series']
      series_description = page_data['series_description']
      if !series_name
        puts "Unable to find series name for page: #{page_data['title']}"
        return "<!-- Error with series tag -->"
      end
      if !series_description
        puts "Unable to find series series_description for page: #{page_data['title']}"
        return "<!-- Error with series tag -->"
      end

      all_entries = []
      site.posts.each do |p|
        if p.data['series'] == series_name
          all_entries << p
        end
      end

      all_entries.sort_by { |p| p.date.to_f }

      text = "<div class='well well-large'>"
      text += "<h3>Series: #{series_name}</h3>"
      text += "<p>#{series_description}</p>"
      list = "<ul class='nav nav-tabs nav-stacked'>"
      all_entries.each_with_index do |post, idx|
        list += "<li>"
        if post.data['title'] == page_data['title']
          list += "<li class='active'><a href='javascript:;'>#{post.data['title']}</a></li>"
        else
          list += "<li><a href='#{post.url}/'>#{post.data['title']}</a></li>"
        end
      end
      text += list += "</ul></div>"
      
    end
  end
end

Liquid::Template.register_tag('series_list', Jekyll::SeriesTag)
