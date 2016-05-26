class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook , :google_oauth2]
	enum role: [:end_user , :admin]
  enum status: [:suspended , :active]
	has_many :rooms , dependent: :destroy
  has_many :reports, :as => 'reporter' , dependent: :destroy
  has_many :checkins , dependent: :destroy
  has_many :voteups , dependent: :destroy

	def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
      end
  	end
end
