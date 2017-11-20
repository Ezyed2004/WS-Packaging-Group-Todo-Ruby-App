class Attachment < ApplicationRecord
  belongs_to :task
  attr_accessor :file
end