class Shooting
  include Mongoid::Document
  include Mongoid::Timestamps
  

  STATUSES = %w{ new waiting_photos conforming approving waiting_retouch finished }
  
  field :yammer_url, :type => String
  field :yammer_page_id, :type => String
  field :title, :type => String
  field :inline_content, :type => String
  field :status, :type => String
  field :progression, :type => Integer

  has_many :photos

  def self.get_shootings_from_yammer(yammer_client)
    # do a yammer search to get all pages with tag 'yaflow'
    # find or create every shooting of the list
    #
    topic=Yammer::Topic.find_by_name("Yaflow",yammer_client)
    parsed_all = JSON.parse(yammer_client.raw_request("messages/about_topic/#{topic.id}").body) unless topic.nil?
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
      shooting.yammer_url = p[:url]
      shooting.title = p[:title]
      shooting.inline_content = p[:content]
      # create non existing shooting
      unless shooting.persisted?
        shooting.status = "new"
        shooting.progression = 0
        shooting.save
      end
      shootings.insert(-1, shooting)
    end
    shootings
  end

end
