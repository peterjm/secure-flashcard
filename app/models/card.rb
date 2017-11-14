class Card < ApplicationRecord

  validates :question, presence: true
  validates :answer_encrypted, presence: true

  def self.find_for_attempt
    Card.all.sample
  end

  def answer
    BCrypt::Password.new(answer_encrypted) if answer_encrypted
  end

  def answer=(value)
    self.answer_encrypted = BCrypt::Password.create(value)
  end

end
