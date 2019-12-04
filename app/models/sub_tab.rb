class SubTab < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :main_tab
  has_rich_text :body

  def should_generate_new_friendly_id?
    title_changed?
  end
end
