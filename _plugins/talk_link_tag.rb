require 'yaml'

module Jekyll
  class TalkLinkTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @slug = text.strip
    end

    def render(context)
      talks = context.registers[:site].data['talks']
      talk = talks.find { |t| t['slug'] == @slug }
      %Q(<a href="/talks/#{talk['slug']}.html">#{talk['talk']['title']}</a>)
    end
  end
end

Liquid::Template.register_tag('talk_link', Jekyll::TalkLinkTag)
