class PageDecorator

  attr_reader :page

  attr_accessor :created_at, :tags

  def initialize(page)
    @page = page
  end

  def title
    html_dom.css("meta[name='og:description']").attribute("content")&.value ||
    html_dom.css("meta[name='twitter:description']").attribute("content")&.value
  end

  def description
    html_dom.css("meta[name='og:image']").attribute("content")&.value ||
    html_dom.css("meta[name='twitter:image']").attribute("content")&.value
  end

  def image_url
    html_dom.css("meta[name='og:image']").attribute("content")&.value ||
    html_dom.css("meta[name='twitter:image']").attribute("content")&.value
  end

  private

  def html_dom
    Scrapper::html_dom(page)
  end
end