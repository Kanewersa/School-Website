class SubTab < ApplicationRecord
  extend FriendlyId
  include RailsSortable::Model
  include Requestable
  belongs_to :main_tab
  has_one :gallery

  friendly_id :title, use: :slugged
  has_rich_text :body
  set_sortable :sort

  def should_generate_new_friendly_id?
    title_changed?
  end
end
