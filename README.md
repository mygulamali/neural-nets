# Neural Networks in Ruby

## Synopsis

This repo is based on the free online book, [Neural Networks and Deep Learning][tutorial],
by [Michael Nielsen][nielsen].  Written in [Ruby][ruby], it provides a command
line app to explore the material in the book.

I created this as part of a company hack day, as a means for me to learn more
about neural networks as well as improve my Ruby-fu, so it's probably not
complete or particularly well documented.  I certainly wouldn't recommend using
it as "production" code, but it might be a useful starting point.

Enjoye!

## Setup

### 1. Install prerequisites for [NMatrix][nmatrix]

These steps are necessary in order to successfully install the [NMatrix][nmatrix]
gem on [Mac OS X Yosemite][osx].  Please see the [installation wiki][nmatrix-installation]
for the right way to do this for your particular platform.

#### A. Install the latest version of [GCC][gcc]
```bash
brew install gcc
sudo mv /usr/bin/gcc /usr/bin/gcc-apple
sudo ln -nfs /usr/local/bin/gcc-5 /usr/bin/gcc
sudo ln -nfs /usr/local/bin/g++-5 /usr/bin/g++
```

#### B. Install the [ATLAS][atlas] libraries
Download the Max OS X 10.8 SDK from [here][osx-sdks-mediafire] (or via
[here][osx-sdks]). Then,
```bash
tar -zxf MacOSX10.8.sdk.tar.xz
sudo mv MacOSX10.8.sdk /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/
```

#### C. Make links to the necessary header files and libraries
```bash
sudo ln -s /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk/usr/lib/libatlas.dylib /usr/lib/libatlas.dylib
sudo ln -s /System/Library/Frameworks/Accelerate.framework/Versions/Current/Frameworks/vecLib.framework/Versions/Current/Headers/cblas.h /usr/include/cblas.h
sudo ln -s /System/Library/Frameworks/Accelerate.framework/Versions/Current/Frameworks/vecLib.framework/Versions/Current/libBLAS.dylib /usr/lib/libblas.dylib
sudo ln -s /System/Library/Frameworks/Accelerate.framework/Versions/Current/Frameworks/vecLib.framework/Versions/Current/Headers/clapack.h /usr/include/clapack.h
sudo ln -s /System/Library/Frameworks/Accelerate.framework/Versions/Current/Frameworks/vecLib.framework/Versions/Current/libLAPACK.dylib /usr/lib/liblapack.dylib
sudo ln -s /System/Library/Frameworks/Accelerate.framework/Versions/Current/Frameworks/vecLib.framework/Versions/Current/libLAPACK.dylib /usr/lib/libclapack.dylib
```

#### D. (Re)install Ruby
```bash
CC=/usr/bin/gcc rbenv install -f 2.2.2
```

### 2. Install [Imagemagick][imagemagick]
```bash
brew install pkg-config imagemagick
```

### 3. Install gems
```bash
bundle install
```

### 4. Download the [MNIST datasets][mnist-data]
```bash
cd data
wget http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz
wget http://yann.lecun.com/exdb/mnist/train-labels-idx1-ubyte.gz
wget http://yann.lecun.com/exdb/mnist/t10k-images-idx3-ubyte.gz
wget http://yann.lecun.com/exdb/mnist/t10k-labels-idx1-ubyte.gz
gunzip *.gz
```

## Usage

...

## License

This software is released under the terms and conditions of [The MIT License][license].
Please see the LICENSE.txt file for more details.

[atlas]: http://math-atlas.sourceforge.net/
[gcc]: https://gcc.gnu.org/
[imagemagick]: http://www.imagemagick.org/
[license]: http://www.opensource.org/licenses/mit-license.php
[mnist-data]: http://yann.lecun.com/exdb/mnist/
[nielsen]: http://michaelnielsen.org/
[nmatrix]: https://github.com/SciRuby/nmatrix
[nmatrix-installation]: https://github.com/SciRuby/nmatrix/wiki/Installation
[osx]: https://www.apple.com/osx/
[osx-sdks]: https://github.com/phracker/MacOSX-SDKs
[osx-sdks-mediafire]: https://www.mediafire.com/?a4g384ysgy5rg
[ruby]: https://www.ruby-lang.org/en/
[tutorial]: http://neuralnetworksanddeeplearning.com/
