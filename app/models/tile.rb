class Tile
  attr_accessor :type, :style, :content, :width, :columns

  def initialize(xml)
    @type = xml.attributes['type'].text
    @width = xml.attributes['width'].text rescue nil
    @columns = xml.attributes['columns'] ? xml.attributes['columns'].text.to_i : 1
    @style = xml.attributes['style'] ? xml.attributes['style'].text : nil
    @content = xml.inner_html

    @attrs = {}

    xml.attributes.keys.each {|key| @attrs[key.to_sym] = xml.attributes[key].text}

    if @type == 'video'
      xml.children.each do |child|
        case child.name
        when 'youtube'
          @youtube_url = child.attributes['url'].text
        end
      end
    end
  end

  def method_missing(key, *args)
    @attrs[key]
  end

# Video element methods
  def flash_embed(options = {})
    options = {:autoplay => false, :width => '100%', :height => '100%'}.merge(options)

    if @youtube_url
      id = @youtube_url[/v=(\w+)/,1]
      id ||= @youtube_url[/v\/(\w+)/,1]
      ap = "autoplay=" + (options[:autoplay] ? "1" : "0")
      "<embed src=\"http://www.youtube.com/v/#{id}&#{ap}&fs=1&showinfo=0&showsearch=0&rel=0\" type=\"application/x-shockwave-flash\" allowscriptaccess=\"always\" allowfullscreen=\"true\" wmode=\"opaque\" width=\"#{options[:width]}\" height=\"#{options[:height]}\" id=\"myytplayer\"></embed>"
    else
      nil
    end
  end

end

