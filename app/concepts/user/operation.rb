require "bcrypt"
require "reform/form/validation/unique_validator.rb"

class User < ActiveRecord::Base
  class Create < Trailblazer::Operation
    include Model; model User, :create

    contract do
      property :email
      property :password, virtual: true

      validates :email,    presence: true, email: true, unique: true
      validates :password, presence: true
    end

    def process(params)
      validate(params[:user]) do |f|
        generate_digest
        f.save
      end
    end

    def generate_digest
      model.password_digest = BCrypt::Password.create(contract.password)
    end
  end
end
