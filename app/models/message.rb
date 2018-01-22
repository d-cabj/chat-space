class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :body, presence: true, unless: :message_img?

  mount_uploader :message_img, MessageImgUploader
end
