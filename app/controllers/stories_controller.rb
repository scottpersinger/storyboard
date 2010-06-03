class StoriesController < ApplicationController
  before_filter :require_user, :except => [:show]
  helper :page
  
  def new
    @story = Story.new
  end

  def create
    @story = Story.new(params[:story])
    @story.user = @current_user
    if @story.save
      flash[:notice] = "Story created!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end

  def show
    @story = Story.find(params[:id])
    @story.parse_body
    
    @page_name = params[:page]

    @page = @page_name ? @story.page_named(@page_name) : @story.first_page
    @prev_page = @story.prev_page(@page)
    @next_page = @story.next_page(@page)

    @pagenum = 0

    render :layout => 'story'
  end

  def edit
    @story = @current_user.stories.find(params[:id])
  end

  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    @story = @current_user.stories.find(params[:id])
    if @story.update_attributes(params[:story])
      flash[:notice] = "Story updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
end
