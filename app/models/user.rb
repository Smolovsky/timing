class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :days

  before_save :ensure_authentication_token!

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  def self.find_for_facebook_oauth access_token
    if user=User.where(url: access_token.info.urls.Facebook).first

      user
    else
      User.create!(:provider => access_token.provider, :url => access_token.info.urls.Facebook,
                   :username => access_token.extra.raw_info.name, :nickname => access_token.extra.raw_info.username,
                   :email => "#{access_token.uid}@facebook.com", :password => Devise.friendly_token[0,20])
    end
  end

  def self.find_for_vkontakte_oauth access_token
    if user = User.where(url: access_token.info.urls.Vkontakte).first
      user
    else
      #binding.pry
      User.create!(:provider => access_token.provider, :url => access_token.info.urls.Vkontakte,
                   :username => access_token.info.name, :nickname => access_token.extra.raw_info.domain,
                   :email => "#{access_token.uid}@vk.com", :password => Devise.friendly_token[0,20])
    end
  end

  def generate_secure_token_string
    SecureRandom.urlsafe_base64(25).tr('lIO0', 'sxyz')
  end

  def password_complexity
    if password.present? and not password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W]).+/)
      errors.add :password, "must include at least one of each: lowercase letter, uppercase letter, numeric digit, special character."
    end
  end

  def password_presence
    password.present? && password_confirmation.present?
  end

  def password_match
    password == password_confirmation
  end

  def ensure_authentication_token!
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def generate_authentication_token
    loop do
      token = generate_secure_token_string
      break token unless User.where(authentication_token: token).first
    end
  end

  def reset_authentication_token!
    self.authentication_token = generate_authentication_token
  end
end
