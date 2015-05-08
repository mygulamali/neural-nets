require 'thor'

require_relative 'image'
require_relative 'mnist_data'

class Commands < Thor
  include Thor::Actions

  MNIST_TEST_IMAGE_DATA = 'data/t10k-images-idx3-ubyte'
  MNIST_TEST_LABEL_DATA = 'data/t10k-labels-idx1-ubyte'

  desc "check_data N IMAGE_FILENAME", "Retrieve data for specified index in MNIST test data."
  def check_data(n, filename)
    n = n.to_i

    print "Getting image data... "
    image_data = MNISTData::Images.new(MNIST_TEST_IMAGE_DATA)
    image = Image.new(image_data.width, image_data.height, image_data.image(n))
    image.save(filename)
    print "Done. Image saved to: #{filename}\n"

    print "Getting label data... "
    label_data = MNISTData::Labels.new(MNIST_TEST_LABEL_DATA)
    label = label_data.label(n)
    print "Done. Label is: #{label}\n"
  end
end
