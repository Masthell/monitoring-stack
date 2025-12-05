# Monitoring Stack - Docker/Prometheus/Grafana

## DESCRIPTION

Complete monitoring solution for Docker environments using Prometheus,
Grafana, and Node Exporter. Ready for production deployment.

Components:

- **prometheus** - Metrics collection and alerting
- **grafana** - Visualization and dashboards
- **node-exporter** - Host-level metrics collection

example
![Image1](https://github.com/Masthell/monitoring-stack/blob/main/docs/screenshots/2025-12-05%20144431.png)
there's also a folder of screenshots from my work

## QUICK START

```bash
# Clone and run
git clone https://github.com/Masthell/monitoring-stack.git
cd monitoring-stack
docker-compose up -d

# Verify
curl http://localhost:9090/-/healthy      # Prometheus
curl http://localhost:3000                # Grafana (admin/admin)
curl http://localhost:9100/metrics        # Node Exporter
INSTALLATION
Requirements
Docker 20.10+ and Docker Compose 2.0+

Ports 9090, 3000, 9100 available

Full Installation
./scripts/deploy.sh
Manual Installation
Clone repository
Copy docker-compose.yml and configuration files
Run docker-compose up -d
Access services (see URLs below)

CONFIGURATION
File Structure
monitoring-stack/
├── docker-compose.yml           # Main configuration
├── prometheus/
│   ├── prometheus.yml          # Prometheus config
│   └── alerts.yml              # Alert rules
├── grafana/provisioning/       # Grafana auto-config
├── node-exporter/install.sh    # Remote host installer
└── scripts/deploy.sh           # Deployment script

URLs
Prometheus: http://localhost:9090
Grafana: http://localhost:3000 (admin/admin)
Node Exporter: http://localhost:9100

Adding New Hosts
# On remote host
sudo ./node-exporter/install.sh
# In prometheus/prometheus.yml, add:
# - job_name: 'new-host'
#   static_configs:
#     - targets: ['host-ip:9100']


prom/prometheus:latest
grafana/grafana:latest
prom/node-exporter:latest

VERSION HISTORY
v1.0.0 (2025) - Initial release with basic monitoring stack

CONTACT
GitHub: https://github.com/Masthell
Project: https://github.com/Masthell/monitoring-stack
```
