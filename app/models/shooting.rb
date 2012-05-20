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

end
