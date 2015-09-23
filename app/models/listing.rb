class Listing < ActiveRecord::Base
  if Rails.env.development?
    has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "default_image.jpg"
  else
    has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "default_image.jpg",
      
  end
  
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
