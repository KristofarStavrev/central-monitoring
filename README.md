# Central Monitoring

## Overview
This repository provides a ready-to-use setup for log and metrics monitoring using [Loki](https://grafana.com/oss/loki/), [Prometheus](https://prometheus.io/), and [Grafana](https://grafana.com/grafana/). It includes pre-configured dashboards and data sources for efficient log aggregation, metrics collection, and visualization.

## Features
- **Loki**: Log aggregation system, optimized for storing and querying logs.
- **Prometheus**: Metrics collection and monitoring system.
- **Grafana**: Visualization tool with dashboards for log and metrics analysis.
- **Pre-configured Dashboards**: Example dashboards for sentiment application monitoring.
- **Docker Compose**: Easy deployment with a single command.

## Repository Structure

- `docker-compose.yml` - Orchestrates Loki, Grafana, and Prometheus containers.
- `grafana/` - Grafana configuration, dashboards, and data sources.
- `loki/` - Loki configuration and storage directories.
- `prometheus/` - Prometheus configuration and data storage.

## Prerequisites
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/)

## Quick Start

1. **Clone the repository:**
   ```bash
   git clone https://github.com/KristofarStavrev/central-monitoring.git
   cd central-monitoring
   ```

2. **Start the stack:**
   ```bash
   docker-compose up -d
   ```

3. **Access Grafana:**
   - Open your browser and go to: [http://localhost:3000](http://localhost:3000)
   - Default credentials: `admin` / `admin` (you will be prompted to change the password)

4. **Access Prometheus:**
   - Open your browser and go to: [http://localhost:9090](http://localhost:9090)
   - Use the Prometheus UI to explore metrics and run queries.

5. **View Dashboards in Grafana:**
   - Pre-configured dashboards are available under the "Dashboards" section in Grafana. These include panels for both logs (from Loki) and metrics (from Prometheus).

## Configuration

- **Grafana**: Configured via `grafana/grafana.ini` and provisioning files in `grafana/provisioning/`.
- **Loki**: Configured via `loki/loki.yml`.
- **Prometheus**: Uses a dynamic configuration process for sensitive values. The actual `prometheus.yml` is generated at container startup from `prometheus/prometheus.yml.template` using environment variables (see below for details).

## Customization

- Add or modify dashboards in `grafana/provisioning/dashboards/`.
- Update data sources in `grafana/provisioning/datasources/` (including Prometheus and Loki sources).
- Adjust Loki or Prometheus configuration as needed for your environment (e.g., scrape configs, retention policies).

## Prometheus Configuration & Security

**Sensitive values (such as scrape targets and credentials) are not committed to the repository.**

- The repository includes a `prometheus/prometheus.yml.template` file with placeholders for sensitive values (e.g., `__PROMETHEUS_SCRAPE_TARGET__`, `__PROMETHEUS_AUTH_UNAME__`, `__PROMETHEUS_AUTH_PASS__`).
- At container startup, the `prometheus/entrypoint.sh` script replaces these placeholders with environment variables provided via Docker Compose (typically from a local `.env` file).
- The resulting `prometheus.yml` is created inside the container and used by Prometheus.
- This approach keeps sensitive information out of version control and allows for flexible configuration per environment.

**To customize Prometheus targets or credentials:**
1. Edit your `.env` file (not committed) to set:
   - `PROMETHEUS_SCRAPE_TARGET` (e.g., `myapp:8000`)
   - `PROMETHEUS_AUTH_UNAME` (username, if needed)
   - `PROMETHEUS_AUTH_PASS` (password, if needed)
2. If you need to change the scrape configuration, edit `prometheus/prometheus.yml.template`.
3. The `entrypoint.sh` script will automatically generate the correct `prometheus.yml` at container startup.

**Note:**
- Do not commit the generated `prometheus.yml` or your `.env` file to version control.
- Only the template and entrypoint script are tracked in git.
