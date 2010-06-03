module PageHelper
  def render_tile(tile, options = {})
    @tile = tile
    @options = options
    send("render_tile_#{tile.type}")
  end

  def render_tile_text
    css = "tile tile-text #{@tile.style}"

    css << " last" if @options[:last_col]

    content_tag('div', :class => css) {
      content_tag(:div, :class => 'text') {@tile.content}
    }
  end

  def render_tile_image
    css = "tile tile-image"
    css << " last" if @options[:last_col]

    content_tag('div',  :class => css) {image_tag(@tile.src)}
  end

  def render_tile_video
    css = "tile tile-video"
    css << " last" if @options[:last_col]

    content_tag('div', :class => css) {
      (@tile.caption ? (content_tag('div', :class => "item-caption") {@tile.caption}) : "") +
      content_tag(:div, :style => "height:90%") {@tile.flash_embed}
    }

  end

  def render_tile_audio
    "<audio here>"
  end
end
