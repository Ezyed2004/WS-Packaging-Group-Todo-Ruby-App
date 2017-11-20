class Task < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :attachments
  attr_accessor :attachments, :remove_attachments

  # Mount and serialize attachments for multiple file uploads
  mount_uploaders :attachments, AttachmentUploader
  serialize :attachments, JSON # JSON datatype doesn't exists in SQLite

  # Task name Validation
  validates :task, presence: true, length: { minimum: 2 }

end