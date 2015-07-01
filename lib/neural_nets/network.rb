module NeuralNets
  class Network
    ##
    # The list ``sizes`` contains the number of neurons in the respective layers
    # of the network.  For example, if the list was [2, 3, 1] then it would be a
    # three-layer network, with the first layer containing 2 neurons, the second
    # layer 3 neurons, and the third layer 1 neuron.  The biases and weights for
    # the network are initialized randomly, using a Gaussian distribution with
    # mean 0, and variance 1.  Note that the first layer is assumed to be an
    # input layer, and by convention we won't set any biases for those neurons,
    # since biases are only ever used in computing the outputs from later layers.
    def initialize(sizes)
      @num_layers = sizes.length
      @sizes = sizes
      initialize_biases
      initialize_weights
    end

    ##
    # Return the output of the network if "a" is input.
    def feedforward(a)
      @biases.zip(@weights).each do |b, w|
        a = NeuralNets::Math.sigmoid_vec(w.dot(a) + b)
      end
      a
    end

    private

    def initialize_biases
      @biases = @sizes[1..-1].collect do |size|
        NMatrix.random([size, 1])
      end
    end

    def initialize_weights
      @weights = @sizes[1..-1].zip(@sizes[0..-2]).collect do |tuple|
        NMatrix.random([tuple.first, tuple.last])
      end
    end

    ##
    # Return the number of test inputs for which the neural network outputs the
    # correct result. Note that the neural network's output is assumed to be the
    # index of whichever neuron in the final layer has the highest activation.
    def evaluate(test_data)
      test_results = test_data.collect do |x, y|
        result = feedforward(x)
        observed_node = result.to_flat_a.find_index(result.max.to_f)
        expected_node = y.to_flat_a.find_index(y.max.to_f)
        observed_node == expected_node ? 1 : 0
      end
      test_results.inject(0, :+)
    end

    ##
    # Return the vector of partial derivatives \partial C_x / \partial a for the
    # output activations.
    def self.cost_derivative(output_activations, y)
      output_activations - y
    end
  end
end
