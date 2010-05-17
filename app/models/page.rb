class Page
  attr_accessor :name, :tiles, :columns
  
  def initialize(xml)
    @name = xml.attributes['name'].text
    @columns = xml.attributes['columns'] ? (xml.attributes['columns'].text.to_i) : 1

    @tiles = xml.search("tile").collect {|tile_xml| Tile.new(tile_xml)}
  end
end