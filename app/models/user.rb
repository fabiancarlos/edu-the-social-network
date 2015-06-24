class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :token_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter, :google_oauth2]

  has_many :posts
  has_many :friendships
  has_many :friends, through: :friendships

  validates :name, presence: true, :allow_blank => false, length: {minimum: 5, maximum: 20}, :format => { :with => /[a-zA-Z][a-zA-Z0-9]/, :message => "apenas letras" }

  before_validation :validate_date_birth_at, on: [:create, :update]
  before_save :camelize_name, on: [:create, :update]
	
  def camelize_name
    self.name = self.name.camelize
  end

  def convert_birth_date_at
    begin
      Date.civil(self.birth_year.to_i, self.birth_month.to_i, self.birth_day.to_i)
    rescue ArgumentError
      false
    end
  end

  def validate_date_birth_at
    errors.add("Data de nascimento", " é inválido") unless convert_birth_date_at
  end
end
