require 'twilio-ruby'
require 'rotp'

class Phone

    @twilio_number = ENV['TWILIO_NUMBER']
    @account_number = ENV['ACCOUNT_SID']
    @auth_token = ENV['AUTH_TOKEN']

    @client = Twilio::REST::Client.new @account_number, @auth_token

  def self.send_message(phone_number, body)
    @client.messages.create(
        :from => @twilio_number,
        :to => phone_number,
        :body => body)
  end

  def self.send_verification(user)
    self.set_verification_code(user)
    self.send_message(user.phone_number, "Your verification code is #{user.code}")
  end

  def self.set_verification_code(user)
    totp = ROTP::TOTP.new("drawtheowl")
    user.code = totp.now
    user.save
  end
end
