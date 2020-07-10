require "nokogiri"
require "faraday"
require 'pry'
require 'concurrent'

module Scrapper
  module_function

  autoload :PageDecorator, "./page_decorator.rb"

  def conn
    @conn ||= Faraday.new(:ssl => {:verify => false})
  end

  def html_dom(html)
    Nokogiri::HTML(html)
  end

  def read_bookmarks
    File.open("bookmarks.html")
  end

  def get_links
    # (
    #   method(:read_bookmarks) >> method(:html_dom)
    # ).call.css("a").first(500)
    html_dom(read_bookmarks).css("a").first(500)
  end

  def get_page(link)
    link_attrs = link.attributes
    url = link_attrs["href"]&.value
    puts url
    html = get_html(url)
    page = PageDecorator.new(html)
    page.created_at = link_attrs["time_added"]&.value.to_i
    page.tags = link_attrs["tags"]&.value
    page
  end

  def get_html(url)
    response = conn.get url, :ssl => {:verify => false}
    response.body
  end
end