require 'thor'

require_relative 'image'
require_relative 'mnist_data'
require_relative 'neural_nets'

class Commands < Thor
  include Thor::Actions

  MNIST_TRAINING_IMAGE_DATA = 'data/train-images-idx3-ubyte'
  MNIST_TRAINING_LABEL_DATA = 'data/train-labels-idx1-ubyte'
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

  desc "train INTERNAL_NODES EPOCHS BATCH_SIZE ETA", "Train the network with the specified parameters."
  def train(internal_nodes, epochs, batch_size, eta)
    print "Getting training data... "
    training_image_data = MNISTData::Images.new(MNIST_TRAINING_IMAGE_DATA)
    training_label_data = MNISTData::Labels.new(MNIST_TRAINING_LABEL_DATA)
    print "Done.\n"

    print "Getting test data... "
    test_image_data = MNISTData::Images.new(MNIST_TEST_IMAGE_DATA)
    test_label_data = MNISTData::Labels.new(MNIST_TEST_LABEL_DATA)
    print "Done.\n"

    print "Preparing data for training... "
    training_data = training_image_data.as_matrices.zip(training_label_data.as_matrices)
    test_data = test_image_data.as_matrices.zip(test_label_data.as_matrices)
    print "Done.\n"

    puts "Training..."
    network = NeuralNets::Network.new([784, internal_nodes.to_i, 10])
    network.sgd(training_data.first(10000), epochs.to_i, batch_size.to_i, eta.to_f, test_data)
    puts "Done."
  end
end
