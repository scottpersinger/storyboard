require 'nokogiri'
require 'ruby-debug'

class SiteController < ApplicationController
  helper :page
  
  def index
    puts "Story:\n#{File.read('story1.xml')}"

    @story = Story.new(:xml => Nokogiri.XML(File.open("story1.xml")))

    @page_name = params[:page]

    @page = @page_name ? @story.page_named(@page_name) : @story.first_page
    @prev_page = @story.prev_page(@page)
    @next_page = @story.next_page(@page)

    @pagenum = 0
    
    render :action => :story
  end
end