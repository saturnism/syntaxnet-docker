SyntaxNet Container
===================

This is an example [SyntaxNet](https://github.com/tensorflow/models/tree/master/syntaxnet/) container.

This example assumes you know how to run Docker.

This is not an official Google product.

Running the Container
---------------------
To run this container:

    $ echo "The quick brown fox jumps over the lazy dog" | docker run -i --rm saturnism/syntaxnet
 
Building the Container
----------------------
Nothing special if you already have Docker installed:

    $ git clone https://github.com/saturnism/syntaxnet-docker.git
    $ cd syntaxnet-docker
    $ docker build -t syntaxnet .
