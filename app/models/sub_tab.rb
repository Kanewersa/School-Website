class SubTab < ApplicationRecord
  extend FriendlyId
  include RailsSortable::Model
  include Requestable
  friendly_id :title, use: :slugged

  belongs_to :main_tab
  has_many :requests, :as => :requestable
  has_rich_text :body
  set_sortable :sort

  #validates :title, :presence => true
  #validates :body, :presence => true

  def should_generate_new_friendly_id?
    title_changed?
  end

  def image
    main_tab.image
  end

end
