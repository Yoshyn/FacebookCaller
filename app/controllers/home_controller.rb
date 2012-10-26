class HomeController < ApplicationController
  def index
    @token = session[:token]
    if session[:token].blank?
      @default_object_id="barackobama"
      session[:obj_id] = @default_object_id
    else
      @default_object_id = session[:obj_id]
    end
  end

  def change_token
    if params[:access_token].blank?
      session[:token] = nil
      flash[:notice] = "You have to enter a valid token to get more permissions."
      redirect_to home_index_url
    return
    else
      session[:token] = params[:access_token]
      @token = session[:token]
      @default_object_id = "me"
      session[:obj_id] = @default_object_id
      flash[:notice] = "Token has been well changed!"
      render :index
    return
    end
  end

  def research_object
    if params[:object_id].blank?
      session[:obj_id] = nil
      @error = true
      @data = 'Please enter an object_id.'
      render :partial => "options_data"
    return
    else
      session[:obj_id] = params[:object_id]
      begin
        graph = Koala::Facebook::API.new(session[:token].to_s)
        @data = graph.get_object(session[:obj_id], :metadata => 1)
        @connection_tab = @data["metadata"]["connections"]
        @result_limit = {"All"=>0,"1"=>1,"5"=>5,"10"=>10,"20"=>20,"40"=>40}

      rescue Exception => e
        @error = true
        @data = 'Error '+e.to_s
      end

    end
    render :partial => "options_data"
    return
  end

  def refresh_object
    begin
      graph = Koala::Facebook::API.new(session[:token].to_s)
      @data = graph.get_connections(session[:obj_id], params[:connection_type], :limit => params[:result_limit])
    rescue Exception => e
      @error = true
      @data = 'Error '+e.to_s
    end
    render :partial => "data"
  end
end