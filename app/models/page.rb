class Page
  attr_accessor :name, :tiles, :columns, :number
  
  def initialize(xml)
    @name = xml.attributes['name'].text
    @columns = xml.attributes['columns'] ? (xml.attributes['columns'].text.to_i) : 1

    @tiles = xml.search("tile").collect {|tile_xml| Tile.new(tile_xml)}
  end

  def resources
    @tiles.inject([]) do |memo, tile|
      memo += tile.resources
      memo
    end.compact
  end
end