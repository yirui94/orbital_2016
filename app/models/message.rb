class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user

  validates :body, presence: true
  validates :conversation_id, presence: true
  validates :user_id, presence: true
end
