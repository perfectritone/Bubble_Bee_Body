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
    @tip.destroy
    respond_to do |format|
      format.html { redirect_to tips_url }
      format.json { head :no_content }
    end
  end

  def callback
    cookies[:access_token] = params[:access_token]
    puts params.inspect



  #   code = params[:code]
  #   if code
  #     @oauth = Koala::Facebook::OAuth.new(Bbb::Application.config.app_id, ENV['FB_APP_SECRET'], "http://localhost:3000/callback")
  #     cookies[:access_token] = @oauth.get_access_token(code)

    @graph = Koala::Facebook::API.new(cookies[:access_token])
    print "IONESTSEKDT\n\n\n\n\n\n\nesinteiaskeistdeksatdekEISKTNE"
    print cookies[:access_token]

    redirect_to Tip.last, notice: cookies[:access_token]
    # if page_id(@graph, "Bubble Bee Body")
    #   print "SETNSESKDNSDKKSEI"
    # else
    #   flash.now[:error] = "The user does not have access to the Facebook Page. Please"\
    #                       " login with a user with the correct permissions."
    # end
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

    # Retrieve the redirect url for Facebook to in turn retrieve the code for the user.
    def get_fb_redirect
      app_id = ENV['FB_APP_ID']
      scope = ['manage_pages', 'publish_stream']
      return get_token_url(app_id, "http://localhost:3000/callback", scope)
    end

    def page_id(graph, page_name)
      accounts = graph.get_connections("me", "accounts")

      # Find the corresponding Page to be posted on and return its id.
      accounts.each do |account| 
        return account['id'] if account['name'] == page_name
      end

      # If it cannot be found return nothing.
      return nil
    end

      # if logged in, it will ask the user for permission to allow app access.
      # user will say yes and be redirected with the code in the url
      # this code will be saved as a cookie.
      # Make sure the user has the BBB Page (the right user is logged in)
      # if it's not the right user, send an error message telling the user to log out
      # once they are logged out they will try this block again.
      # Post to FB
end
