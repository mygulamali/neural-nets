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

    def initial_nabla_b
      @biases.collect { |b| NMatrix.zeros(b.shape) }
    end

    def initial_nabla_w
      @weights.collect { |w| NMatrix.zeros(w.shape) }
    end

    ##
    # Update the network's weights and biases by applying gradient descent using
    # backpropagation to a single mini batch.  The "mini_batch" is a list of
    # tuples "[x, y]", and "eta" is the learning rate.
    def update_mini_batch(mini_batch, eta)
      nabla_b = initial_nabla_b
      nabla_w = initial_nabla_w

      mini_batch.each do |x, y|
        delta_nabla = backprop(x, y)
        nabla_b = nabla_b.zip(delta_nabla.first).collect { |nb, dnb| nb + dnb }
        nabla_w = nabla_w.zip(delta_nabla.last).collect { |nw, dnw| nw + dnw }
      end

      @weights = @weights.zip(nabla_w).collect do |w, nw|
        (w - eta / mini_batch.length)*nw
      end

      @biases = @biases.zip(nabla_b).collect do |b, nb|
        (b - eta / mini_batch.length)*nb
      end
    end

    ##
    # Return a tuple "[nabla_b, nabla_w]" representing the gradient for the cost
    # function C_x.  "nabla_b" and "nabla_w" are layer-by-layer lists of NMatrix
    # arrays, similar to "@biases" and "@weights".
    def backprop(x, y)
      nabla_b = initial_nabla_b
      nabla_w = initial_nabla_w

      # feedforward
      activation = x
      activations = [x] # list to store all the activations, layer by layer
      zs = [] # list to store all the z vectors, layer by layer

      @biases.zip(@weights).each do |b, w|
        z = w.dot(activation) + b
        zs.push(z)
        activation = Math.sigmoid_vec(z)
        activations.push(activation)
      end

      # backward pass
      delta = Network.cost_derivative(activations[-1], y) * Math.sigmoid_prime_vec(zs[-1])
      nabla_b[-1] = delta
      nabla_w[-1] = delta.dot(activations[-2].transpose)

      # Note that the variable l in the loop below is used a little differently
      # to the notation in Chapter 2 of the book.  Here, l = 1 means the last
      # layer of neurons, l = 2 is the second-last layer, and so on.  It's a
      # renumbering of the scheme in the book, used here to take advantage of
      # the fact that Ruby (like Python) can use negative indices in lists.
      (2...@num_layers).each do |l|
        z = zs[-l]
        spv = Math.sigmoid_prime_vec(z)
        delta = @weights[-l + 1].transpose.dot(delta) * spv
        nabla_b[-l] = delta
        nabla_w[-l] = delta.dot(activations[-l - 1].transpose)
      end

      [nabla_b, nabla_w]
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
