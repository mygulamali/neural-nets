require 'nmatrix'

module MNISTData
  class DataUnpackingError < RuntimeError
  end

  class IndexOutOfRangeError < RuntimeError
  end

  class Labels
    def initialize(filename)
      datafile = File.binread(filename)
      @data = datafile.unpack('NNC*')
      @metadata = @data.shift(2)
      raise DataUnpackingError if count != @data.length
    end

    def count
      @metadata[1]
    end

    def label(index)
      raise IndexOutOfRangeError unless index.between?(0, count - 1)
      @data[index]
    end

    def as_matrices
      (0...count).collect do |index|
        nmatrix = NMatrix.zeros([10, 1])
        nmatrix[label(index).to_i, 0] = 1.0
        nmatrix
      end
    end
  end

  class Images
    def initialize(filename)
      datafile = File.binread(filename)
      @data = datafile.unpack('NNNNC*')
      @metadata = @data.shift(4)
      raise DataUnpackingError if count*width*height != @data.length
    end

    def count
      @metadata[1]
    end

    def width
      @metadata[2]
    end

    def height
      @metadata[3]
    end

    def image(index)
      raise IndexOutOfRangeError unless index.between?(0, count - 1)
      pixels = width*height
      range = (index*pixels...(index + 1)*pixels)
      @data[range]
    end

    def as_matrices
      (0...count).collect { |index| NMatrix.new([height*width, 1], image(index)) }
    end
  end
end
