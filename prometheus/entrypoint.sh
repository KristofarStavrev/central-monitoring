#!/bin/sh
# Replace env variables in the template and save the final config since you can't do it natively in the prometheus config 
sed "s|__PROMETHEUS_SCRAPE_TARGET__|$PROMETHEUS_SCRAPE_TARGET|g;
     s|__PROMETHEUS_AUTH_UNAME__|$PROMETHEUS_AUTH_UNAME|g;
     s|__PROMETHEUS_AUTH_PASS__|$PROMETHEUS_AUTH_PASS|g" \
     /prometheus/prometheus.yml.template > /prometheus/prometheus.yml
# Then run the container command (e.g., prometheus)
exec "$@"
