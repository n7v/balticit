class PagesController < ApplicationController
layout :layout
before_filter :menu_main 

  def show
    @projects = Project.all
    @page = Page.find_by_slug(params[:slug]) || Page.find(params[:slug])
    if File.exists?(Rails.root.join("app", "views", params[:controller], "#{params[:slug]}.html.erb"))
      render params[:slug]
    else
      puts 'no'
    end
  end

  def menu_main 
    @page = Page.find_by_slug(params['slug'])
    @top_menu = @page.root.siblings.where(hidden: false) 
    @middle_menu = @page.ancestors.where(hidden: false)
    @bottom_menu = @page.children.where(hidden: false)
    @main_menu = @page.siblings.where(hidden: false)  
  end 

  private
    def layout
      main_layout = 'application'
      if @page && @page.layout != main_layout && File.exists?(Rails.root.join("app", "views", "layouts", "#{@page.layout}.html.erb"))
        @page.layout
      else
        main_layout
      end
    end

end
