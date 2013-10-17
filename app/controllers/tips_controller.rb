class TipsController < ApplicationController
  include Facebook

  before_action :set_tip, only: [:show, :edit, :update, :destroy]

  # GET /tips
  # GET /tips.json
  def index
    @tips = Tip.all
  end

  # GET /tips/1
  # GET /tips/1.json
  def show
  end

  # GET /tips/new
  def new
    @tip = Tip.new
  end

  # GET /tips/1/edit
  def edit
  end

  # POST /tips
  # POST /tips.json
  def create
    @tip = Tip.new(tip_params)

    respond_to do |format|
      if @tip.save
        graph = prepare_facebook_graph
        set_page_id(graph, ENV['PAGE_NAME']) unless session[:page_id]

        # Post the message to the Page's wall
        post_response = graph.put_connections(session[:page_id], 'feed', message: @tip.to_s)

        # If the post was successful, the post response will have the post's
        # FB object id.
        if post_response['id']
          @tip.fb_id = post_response['id']
          @tip.save
        else
          flash.now(error: "Could not post tip to Facebook.")
        end

        format.html { redirect_to @tip, notice: 'Tip was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tip }
      else
        format.html { render action: 'new' }
        format.json { render json: @tip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tips/1
  # PATCH/PUT /tips/1.json
  def update
    respond_to do |format|
      if @tip.update(tip_params)
        if @tip.fb_id
          graph = prepare_facebook_graph
          # put_response = graph.
        end

        format.html { redirect_to @tip, notice: 'Tip was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tips/1
  # DELETE /tips/1.json
  def destroy
    fb_id = @tip.fb_id
    if fb_id
      graph = prepare_facebook_graph
      # Send delete request for the post. If it could not be deleted,
      # the request will return false and will send an error.
      unless graph.delete_object(fb_id)
        set_page_id(graph, ENV['PAGE_NAME'])
        post_url = get_post_url(graph, session[:page_id])
        flash.now(error: "Post could not be deleted on Facebook. "\
          "If you would like to delete it manually go to "\
          "the following address: #{post_url}")
      end
    end
    @tip.destroy
    respond_to do |format|
      format.html { redirect_to tips_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tip
      @tip = Tip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tip_params
      params.require(:tip).permit(:title, :content)
    end

    def set_page_id(graph, page_name)
      accounts = graph.get_connections("me", "accounts")

      # Find the corresponding Page to be posted on and return its id.
      accounts.each do |account| 
        return session[:page_id] = account['id'] if account['name'] == page_name
      end

      # If it cannot be found return nothing.
      return nil
    end

    # Creates the graph and sets the page id to be 
    # persisted in the session.
    def prepare_facebook_graph
      oauth_token = OauthUser.find(session[:oauth_user_id]).oauth_token
      graph = Koala::Facebook::API.new(oauth_token)
    end

    # Take in a page_id and a post_id and return the url of the post.
    def get_post_url(page_id, post_id)
      "https://www.facebook.com/#{page_id}/posts/#{post_id}"
    end
end
