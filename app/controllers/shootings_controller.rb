require "yammer4r"

class ShootingsController < ApplicationController
  before_filter :use_or_welcome
  before_filter :authenticate_user!

  # GET /shootings
  # GET /shootings.json
  def index

    # use a shooting collection cache

    respond_to do |format|
      format.html # index.html.erb
      format.json do
        @shootings = get_shooting_from_yammer
        render json: { shootings: @shootings }
      end
    end
  end

  # GET /shootings/1
  # GET /shootings/1.json
  def show
    @shooting = Shooting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shooting }
    end
  end

  # GET /shootings/new
  # GET /shootings/new.json
  def new
    @shooting = Shooting.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shooting }
    end
  end

  # GET /shootings/1/edit
  def edit
    @shooting = Shooting.find(params[:id])
  end

  # POST /shootings
  # POST /shootings.json
  def create
    @shooting = Shooting.new(params[:shooting])

    respond_to do |format|
      if @shooting.save
        format.html { redirect_to @shooting, notice: 'Shooting was successfully created.' }
        format.json { render json: @shooting, status: :created, location: @shooting }
      else
        format.html { render action: "new" }
        format.json { render json: @shooting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shootings/1
  # PUT /shootings/1.json
  def update
    @shooting = Shooting.find(params[:id])

    respond_to do |format|
      if @shooting.update_attributes(params[:shooting])
        format.html { redirect_to @shooting, notice: 'Shooting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @shooting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shootings/1
  # DELETE /shootings/1.json
  def destroy
    @shooting = Shooting.find(params[:id])
    @shooting.destroy

    respond_to do |format|
      format.html { redirect_to shootings_url }
      format.json { head :no_content }
    end
  end

  def get_shooting_from_yammer
    # do a yammer search to get all pages with tag 'yaflow'
    # find or create every shooting of the list
    #
    # Possible optimisation : put resulted collection in a cache
    logger.debug('############')
    logger.debug("token: #{current_user.access_token}")
    logger.debug('############')
    yammer = Yammer::TokenClient.new(token: current_user.access_token)
    topic=Yammer::Topic.find_by_name("Yaflow",yammer)
    parsed_all = JSON.parse(yammer.raw_request("messages/about_topic/#{topic.id}").body) unless topic.nil?
    msg_with_attach = parsed_all["messages"].select{|m| !m["attachments"].empty? }
    pages = []
    msg_with_attach.each do |m|
      m["attachments"].each do |a|
        pages.insert(-1, {id: a["real_id"], url: a["web_url"], title: a["name"], content: a["inline_html"]}) if a["real_type"] == "page" 
      end
    end
    shootings = []
    pages.each do |p|
      shooting = Shooting.find_or_initialize_by(yammer_page_id: p[:id])
      # create non existing shooting
      unless shooting.persisted?
        shooting.yammer_url = p[:url]
        shooting.title = p[:title]
        shooting.inline_content = p[:content]
        shooting.status = "new"
        shooting.progression = 0
        shooting.save
      end
      shootings.insert(-1, shooting)
    end
    shootings
  end
end
