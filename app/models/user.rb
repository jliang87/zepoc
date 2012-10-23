# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :avatar
  has_secure_password
  before_save { |user| user.email = email.downcase }
  before_save { create_remember_token(:remember_token) }

  valid_name_regex=/\A[\w]+\z/i
  validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 50}
  validates_format_of :name, with: valid_name_regex, message: "can only be alphanumerical with underscores and no spaces in between" 
  valid_email_regex=/\A[\w\-.+]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: valid_email_regex}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true
  
  if Rails.env.development? || Rails.env.test?
    has_attached_file :avatar, styles: {medium: "450x450>", thumb: "150x150>"}
  end
  
  if Rails.env.production?
    has_attached_file :avatar, styles: {medium: "450x450>", thumb: "150x150>"}, 
    storage: :s3, bucket: 'zepocfirst', s3_credentials: {access_key_id: ENV['S3_KEY'], secret_access_key: ENV['S3_SECRET']}
  end

  validates_attachment_size :avatar, less_than: 5.megabytes
  validates_attachment_content_type :avatar, content_type: ['image/jpeg', 'image/png']
  
  def to_param
    name
  end

  def self.send_password_reset(email)
      user = find_by_email(email)
      if user
        create_QCneeded_token(:password_reset_token, user)
        user.password_sent_at = Time.zone.now
        user.need_password_reset = true
        user.save!(validate: false)
        UserMailer.password_reset(user).deliver
      end
  end

  def self.send_signup_confirmation(email)
      user = find_by_email(email)
      if user
        create_QCneeded_token(:signup_confirmation_token, user)
        user.need_signup_confirmation = true
        user.save! validate: false
        UserMailer.signup_confirmation(user).deliver
      end
  end

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end

  private

  def reprocess_avatar
    avatar.reprocess!
  end


#  def change_password_reset
#      create_password_reset_token(:password_reset_token)
#      save!(validate: false)
#  end

  private 
    def create_remember_token(column)
      if self[column].nil?
        begin 
          self[column] = SecureRandom.urlsafe_base64
        end while User.exists?(column => self[column])
      end
    end

    def self.create_QCneeded_token(column, user)
      begin 
        user[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => user[column])
    end
end

