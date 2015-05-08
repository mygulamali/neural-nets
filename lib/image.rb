require 'rmagick'

class Image
  def initialize(width, height, pixels)
    @width = width
    @height = height
    @pixels = pixels
  end

  def save(filename)
    image = Magick::Image.constitute(@width, @height, "I", intensities)
    image.write(filename)
  end

  private

  def self.scaled_intensity(intensity)
    1.0 - 3.90625e-3 * intensity
  end

  def intensities
    @intensities ||= @pixels.collect { |intensity| Image.scaled_intensity(intensity) }
  end
end
