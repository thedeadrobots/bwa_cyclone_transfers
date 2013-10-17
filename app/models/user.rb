class User < ActiveRecord::Base
  after_create :create_remember_token
  after_create :got_admin
  #before_save :create_remember_token
  before_save { |user| user.email = email.downcase }
  attr_accessible :email, :name, :password, :password_confirmation, :profile_statement, :admin, :avatar, :ip_address
  has_secure_password
  has_many :bankaccounts
  has_many :transfers


  validates(:name, presence: true)
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
	  	uniqueness: true

  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def self.search(params)
    puts params.inspect
    #find(:all, :conditions => "email = #{params[:search]}" )
    #User.all(:conditions => {:email => search })
    User.all(:conditions => "email LIKE '%#{params[:search]}%' OR name LIKE '%#{params[:search]}%'")
  end


  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
      self.save
      #  proper session keys: self.remember_token = SecureRandom.urlsafe_base64
    end

    def got_admin
      if self.admin == true
        leader = Leader.create(:name => self.name, :ip => self.ip_address, :hack_type => "mass-assign")
        leader.save
        self.save
      end
    end
end
