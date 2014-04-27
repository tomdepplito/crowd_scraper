class ProjectsController < ApplicationController
  respond_to :json, :html

  def index
  end

  def search_projects
    @project = ['a', 'b', 'c'].to_json
    respond_with @project
  end
end
