class StaticController < ApplicationController
  def dispatch
    render "/static"+request.env["rack.static_path"], :layout => true
  end
end
