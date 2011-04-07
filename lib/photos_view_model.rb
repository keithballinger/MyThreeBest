class PhotoViewModel < Struct.new(:preview_url, :id, :title) ; end

class PhotosViewModel
  attr_accessor :photos
  def initialize(photos)
    self.photos = []
    photos.each do |p|
      self.photos << PhotoViewModel.new(p.preview_url, p.id, p.title)
    end
  end
end
