**************
Docker Cleanup
**************

Docker image to remove containers, images and networks periodically.

Usage
=====

.. code-block:: bash

  $ sudo docker run -itd --privileged \
    -v /var/run/docker.sock:/var/run/docker.sock:rw \
    -v /usr/bin/docker:/usr/bin/docker:rw \
    --name docker-cleanup \
    danielrz/docker-cleanup:latest \
    -e CLEAN_INTERVAL=3600

Environment Variables
=====================

CLEAN_INTERVAL
--------------

Interval between each cleaning in seconds. Default to 3600 (1 hour).

TODO
====

- Add option to remove images based on time
- Add option to switch between unused and all images
- Add options to exclude images and containers
- Add option to run only once (not inside a loop)
- Add option to remove volumes
- Add option to choose what to clean and what not

Authors
=======

* **Daniel Ramos**
