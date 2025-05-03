#!/bin/sh
# Replace env variables in the template and save the final config since you can't do it natively in the prometheus config 
envsubst < /etc/prometheus/prometheus.yml.template > /etc/prometheus/prometheus.yml
# Then run the container command (e.g., prometheus)
exec "$@"
