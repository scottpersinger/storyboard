class ManifestController < ApplicationController
  def index
     @story = Story.new(:xml => Nokogiri.XML(File.open("story1.xml")))
     @resources = @story.resources
     manifest =<<-MANIFEST
CACHE MANIFEST
#{@resources.join("\n")}
MANIFEST

     render :text => manifest, :content_type => 'text/cache-manifest'
  end
end