module NeuralNets
  class Math
    ##
    # The sigmoid function
    def self.sigmoid(x)
      1.0/(1.0 + Math.exp(-x))
    end

    ##
    # NMatrix version of the sigmoid function
    def self.sigmoid_vec(x)
      one = NMatrix.ones([x.rows, x.cols])
      one/(one + (-x).exp)
    end
  end
end
