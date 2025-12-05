#!/bin/bash

# Node Exporter Install Script
# Установка node-exporter на удаленный хост

set -e

VERSION="1.6.1"
INSTALL_DIR="/opt/node_exporter"
SERVICE_FILE="/etc/systemd/system/node-exporter.service"

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1
}

# Проверка прав root
if [[ $EUID -ne 0 ]]; then
    print_error "Этот скрипт должен запускаться с правами root"
    exit 1
fi

# Определение архитектуры
ARCH=$(uname -m)
case $ARCH in
    x86_64)
        ARCH="amd64"
        ;;
    aarch64|arm64)
        ARCH="arm64"
        ;;
    armv7l)
        ARCH="armv7"
        ;;
    *)
        print_error "Неподдерживаемая архитектура: $ARCH"
        exit 1
        ;;
esac

print_info "Установка Node Exporter v${VERSION} для ${ARCH}"

# Создание директории
mkdir -p $INSTALL_DIR
cd $INSTALL_DIR

# Загрузка и распаковка
print_info "Загрузка Node Exporter..."
wget -q https://github.com/prometheus/node_exporter/releases/download/v${VERSION}/node_exporter-${VERSION}.linux-${ARCH}.tar.gz
tar xzf node_exporter-${VERSION}.linux-${ARCH}.tar.gz --strip-components=1
rm node_exporter-${VERSION}.linux-${ARCH}.tar.gz

# Создание systemd сервиса
print_info "Создание systemd сервиса..."
cat > $SERVICE_FILE << SERVICE
[Unit]
Description=Node Exporter
Documentation=https://github.com/prometheus/node_exporter
After=network.target

[Service]
Type=simple
User=root
Group=root
ExecStart=$INSTALL_DIR/node_exporter
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
SERVICE

# Включение и запуск сервиса
print_info "Запуск Node Exporter..."
systemctl daemon-reload
systemctl enable node-exporter
systemctl start node-exporter

# Проверка статуса
sleep 2
if systemctl is-active --quiet node-exporter; then
    print_info "Node Exporter успешно установлен и запущен!"
    print_info "Доступен на: http://$(hostname -I | awk '{print $1}'):9100"
    print_info "Проверка: curl http://localhost:9100/metrics | head -5"
else
    print_error "Ошибка запуска Node Exporter"
    journalctl -u node-exporter --no-pager -n 20
    exit 1
fi