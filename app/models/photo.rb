class Photo < ActiveRecord::Base
  belongs_to :property

  has_attached_file :image, styles: { home: "348x218", medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
