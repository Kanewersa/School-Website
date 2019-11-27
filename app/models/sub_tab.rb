class SubTab < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :main_tab
  has_rich_text :body
end
