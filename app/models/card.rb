class Card < ApplicationRecord
  ATTEMPT_THRESHOLD = 1.hour

  validates :question, presence: true
  validates :answer_encrypted, presence: true

  def self.find_for_attempt
    Card.where('last_successful_attempt_at IS NULL OR last_successful_attempt_at < ?', ATTEMPT_THRESHOLD.ago).sample
  end

  def answer
    BCrypt::Password.new(answer_encrypted) if answer_encrypted
  end

  def answer=(value)
    self.last_successful_attempt_at = nil
    self.answer_encrypted = BCrypt::Password.create(value)
  end

  def mark_successful_attempt
    update!(last_successful_attempt_at: Time.now)
  end
end
