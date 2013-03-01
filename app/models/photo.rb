class Photo < ActiveRecord::Base
  belongs_to :user

  attr_accessible :user_id, :name, :description, :photo, :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  after_update :reprocess_photo, if: :cropping?


  if Rails.env.development? || Rails.env.test?
    has_attached_file :photo, :styles => {medium: "450x450>", thumb: "150x150#"}, processors: [:cropper, :thumbnail],
                      :path => ":rails_root/public/system/:photo/:id/:style/:filename",
                      :url => "/system/:photo/:id/:style/:filename"
  end

  if Rails.env.production?
    has_attached_file :photo, styles: {medium: "450x450>", thumb: "150x150#"}, processors: [:cropper, :thumbnail],
                      storage: :s3, bucket: 'zepocfirst',
                      s3_credentials: {access_key_id: ENV['S3_KEY'], secret_access_key: ENV['S3_SECRET']},
                      :path => ":rails_root/public/system/:photo/:id/:style/:filename",
                      :url => "/system/:photo/:id/:style/:filename"
  end

  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']


  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def photo_geometry(style = :original)
    if Rails.env.development? || Rails.env.test?
      @geometry ||= {}
      @geometry[style] ||= Paperclip::Geometry.from_file(photo.path(style))

    elsif Rails.env.production?
      @geometry ||= {}
      @geometry[style] ||= Paperclip::Geometry.from_file(photo.to_file(style))
    end
  end

  private
    def reprocess_photo
      photo.reprocess!
    end

end
