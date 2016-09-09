class User < ActiveRecord::Base

    AGE_REGEX = /\d/i

    attr_accessor :remember_token
    before_save {self.email = email.downcase}
    before_save :generate_token_for_auth
    validates :email, presence: true, uniqueness:{case_sensitive: false}
    has_secure_password
    validates :password, length: {minimum: 6}, on: :create
    validates :password,length: {minimum: 6},allow_blank: true, on: :update
    validates :age,format: {:with => AGE_REGEX},length: {maximum: 2},on: :update


    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string,cost: cost)
    end
    def self.new_token
        SecureRandom.urlsafe_base64
    end
    def generate_auth_token
        begin
            self.remember_token = self.class.new_token
            self.auth_token = self.class.digest(remember_token)
        end while self.class.exists?(auth_token: auth_token)
        update(auth_token: User.digest(remember_token))
    end

    def generate_token_for_auth
        begin
            self.remember_token = self.class.new_token
            self.auth_token = self.class.digest(remember_token)
        end while self.class.exists?(auth_token: auth_token)
    end
end
