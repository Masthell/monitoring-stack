# 🚀 Monitoring Stack: Prometheus + Grafana + Node Exporter

## 📊 Project Overview
A complete monitoring solution deployed across multiple Linux virtual machines, collecting real-time system metrics and visualizing them through interactive dashboards.

## 🏗️ System Architecture
Windows Host (Main OS)
├── Ubuntu Server VM (192.168.1.100) - Monitoring Server
│ ├── Prometheus (port 9090) - Metrics storage and collection
│ ├── Grafana (port 3000) - Dashboards and visualization
│ └── Node Exporter (port 9100) - Self-monitoring metrics
└── Kali Linux VM (192.168.1.101) - Monitored Host
└── Node Exporter (port 9100) - Host metrics collectio

## 🛠️ Technologies Stack
| Component | Purpose | Port |
|-----------|---------|------|
| **Prometheus** | Time-series database for metrics | 9090 |
| **Grafana** | Visualization and dashboards | 3000 |
| **Node Exporter** | System metrics collection | 9100 |
| **Docker** | Containerization platform | - |
| **Ubuntu Server** | Monitoring server OS | - |
| **Kali Linux** | Monitored client OS | - |

## 🚀 Quick Start
# Clone the repository
git clone https://github.com/txsmast/monitoring-stack.git
cd monitoring-stack

# Deploy the monitoring stack
docker-compose up -d

# Verify deployment
docker-compose ps
📁 Project Structure
.
├── docker-compose.yml          # Docker Compose configuration
├── prometheus.yml              # Prometheus configuration
├── README.md                   # Project documentation
├── docs/                       # Documentation
│   ├── screenshots/           # System screenshots
│   └── setup_guide.md         # Detailed setup instructions
└── scripts/                    # Utility scripts
    └── deploy.sh              # Automated deployment script
Key Features


📈 Collected Metrics
Metric	Description	Example Query
CPU Usage	Processor utilization per core	rate(node_cpu_seconds_total[1m])
Memory Usage	RAM consumption	node_memory_MemTotal_bytes - node_memory_MemAvailable_bytes
Disk Space	Filesystem usage	node_filesystem_avail_bytes
Network Traffic	Network interface statistics	rate(node_network_receive_bytes_total[5m])
System Uptime	Host uptime	node_time_seconds - node_boot_time_seconds
Running Processes	Number of processes	node_procs_running
🎓 Skills Demonstrated
Linux Administration
System service management (systemd, journalctl)
Network configuration (netplan, static IP assignment)
User and permission management
Networking
Port configuration and firewall management
Inter-VM communication setup
DNS and gateway configuration

Docker & Containerization
Docker Compose deployment

Container lifecycle management

Volume and network configuration

Monitoring & Observability
Prometheus configuration and query language

Grafana dashboard creation

Metrics collection and visualization

Troubleshooting
Log analysis with journalctl and docker logs

Network debugging (ping, curl, ss)

Service health monitoring

🔗 Access URLs
Service	URL	Credentials
Prometheus	http://192.168.1.100:9090	None
Grafana	http://192.168.1.100:3000	admin / admin123
Node Exporter (Ubuntu)	http://192.168.1.100:9100/metrics	None
Node Exporter (Kali)	http://192.168.1.101:9100/metrics	None

