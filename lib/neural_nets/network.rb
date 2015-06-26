module NeuralNets
  class Network
    def initialize(sizes)
      @num_layers = sizes.length
      @sizes = sizes
      initialize_biases
      initialize_weights
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
  end
end
