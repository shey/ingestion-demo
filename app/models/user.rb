# app/models/user.rb
class User < ApplicationRecord
  before_create :generate_api_key

  private

  def generate_api_key
    self.api_key = "alert_app#{SecureRandom.hex(32)}"
  end
end
