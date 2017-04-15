class Request < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :insta_handle, presence: true
end
