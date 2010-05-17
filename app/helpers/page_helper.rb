module PageHelper
  def render_tile(tile)
    @tile = tile
    send("render_tile_#{tile.type}")
  end

  def render_tile_text
    content_tag('div', :class => "tile-text #{@tile.style}") {
      content_tag(:div, :class => 'text') {@tile.content}
    }
  end

  def render_tile_image
    content_tag('div',  :class => "tile-image") {image_tag(@tile.src)}
  end

  def render_tile_video
    content_tag('div', :class => "tile-video") {
      (@tile.caption ? (content_tag('div', :class => "item-caption") {@tile.caption}) : "") +
      content_tag(:div, :style => "height:90%") {@tile.flash_embed}
    }

  end
end
