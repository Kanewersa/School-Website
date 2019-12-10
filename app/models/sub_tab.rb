class SubTab < ApplicationRecord
  extend FriendlyId
  belongs_to :main_tab
  friendly_id :title, use: :slugged
  has_rich_text :body


  def should_generate_new_friendly_id?
    title_changed?
  end
end
