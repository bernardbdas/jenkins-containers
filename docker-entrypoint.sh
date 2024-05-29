#!/bin/sh

# Start Docker daemon
rc-service docker start

# Keep the container running
exec "$@"
