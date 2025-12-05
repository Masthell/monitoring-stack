#!/bin/bash
# Скрипт развертывания мониторинга

set -e

echo "Развертывание стека мониторинга..."

# Проверка Docker
if ! command -v docker &> /dev/null; then
    echo "Docker не установлен"
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose не установлен"
    exit 1
fi

# Запуск стека
echo "Запуск контейнеров..."
docker-compose down 2>/dev/null || true
docker-compose up -d

echo "Ожидание запуска сервисов..."
sleep 10

# Проверка
echo "Проверка сервисов..."
services=("prometheus" "grafana" "node-exporter")
for service in "${services[@]}"; do
    if docker-compose ps | grep -q "$service.*Up"; then
        echo "$service запущен"
    else
        echo "$service не запущен"
    fi
done

echo ""
echo "🎉 Развертывание завершено!"
echo "📊 Prometheus:  http://localhost:9090"
echo "📈 Grafana:     http://localhost:3000 (admin/admin)"
echo "📡 Node Exporter: http://localhost:9100"