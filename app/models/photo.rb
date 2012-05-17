class Photo
  include Mongoid::Document
  include Mongoid::Timestamps

  STATUSES = %w{ new conforming not_conform approving retouching finished }

  field :yammer_url, :type => String
  field :status, :type => String

  belongs_to :shooting
end
