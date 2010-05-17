class Story
  attr_accessor :pages, :title

  # Values: :title, :pages => array of pages
  # Values: :xml => Nokogiri doc
  def initialize(values)
    if values[:xml]
      vals = {}
      vals[:title] = values[:xml].attributes['title'].text rescue nil
      vals[:pages] = values[:xml].search("page").collect {|xml| Page.new(xml)}
      values = vals
    end

    @title = values[:title]
    @pages = values[:pages]
  end

  def first_page
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