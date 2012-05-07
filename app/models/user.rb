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
  before_save { create_remember_token(:remember_token) }

  valid_name_regex=/\A[\w]+\z/i
  validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 50}
  validates_format_of :name, with: valid_name_regex, message: "can only be alphanumerical with underscores and no spaces in between" 
  valid_email_regex=/\A[\w\-.+]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: valid_email_regex}, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6}
  
  if Rails.env.development? || Rails.env.test?
    has_attached_file :avatar, styles: {medium: "300x300>", thumb: "100x100>"}
  end
  
  if Rails.env.production?
    has_attached_file :avatar, styles: {medium: "300x300>", thumb: "100x100>"}, storage: :s3, bucket: 'zepocfirst', s3_credentials: {access_key_id: ENV['S3_KEY'], secret_access_key: ENV['S3_SECRET']}
  end
  
  def to_param
    name
  end

  def send_password_reset
      create_remember_token(:password_reset_token)
      self.password_sent_at = Time.zone.now
      save!(validate: false)
      UserMailer.password_reset(self).deliver
  end

  private 
    def create_remember_token(column)
      begin 
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end
end

