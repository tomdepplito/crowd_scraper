class ProjectsController < ApplicationController
  respond_to :json, :html

  def index
    binding.pry
    @project = ['a', 'b', 'c'].to_json
    respond_with @project
  end
end
