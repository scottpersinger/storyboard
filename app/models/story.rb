require 'nokogiri'

class Story < ActiveRecord::Base
  belongs_to :user

  attr_accessor :pages

  # Values: :title, :pages => array of pages
  # Values: :xml => Nokogiri doc
  def parse_body
    return if @doc

    @doc = Nokogiri.XML(self.body)
    values = {}
    values[:title] = @doc.attributes['title'].text rescue nil
    @doc.search('background').each do |bkelt|
      if bkelt.attributes['image']
        @background_image = bkelt.attributes['image']
      end
    end
    values[:pages] = @doc.search("page").collect {|xml| Page.new(xml)}

    @title = values[:title]
    @pages = values[:pages]
    @pages.each_with_index {|page,idx| page.number = idx}
  end

  def resources
    parse_body

    res = []
    res << @background_image if @background_image
    self.pages.each do |page|
      res += page.resources
    end
    res.flatten
  end
  
  def first_page
    parse_body

    @pages.first
  end
  
  def page_named(name)
    @pages.find {|page| page.name == name}
  end

  def prev_page(target)
    @pages.each_with_index do |page, idx|
      if page == target && idx > 0
        return @pages[idx-1]
      end
    end
    nil
  end

  def next_page(target)
    @pages.each_with_index do |page, idx|
      if page == target && idx < (@pages.size-1)
        return @pages[idx+1]
      end
    end
    nil
  end


end