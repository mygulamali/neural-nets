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
      one = NMatrix.ones(x.shape)
      one/(one + (-x).exp)
    end

    ##
    # Derivative of the sigmoid function
    def self.sigmoid_prime(x)
      sigma = self.sigmoid(x)
      sigma*(1.0 - sigma)
    end

    ##
    # NMatrix version of the derivative of the sigmoid function
    def self.sigmoid_prime_vec(x)
      one = NMatrix.ones(x.shape)
      sigma = self.sigmoid_vec(x)
      sigma.dot(one - sigma)
    end
  end
end
