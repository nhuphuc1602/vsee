#!/bin/bash

# GỢI Ý: nên chạy bằng ./selenium_grid_start.sh sau khi chmod +x

# Check Docker installation
if ! command -v docker &> /dev/null; then
  echo "❌ Docker chưa được cài. Vui lòng cài Docker trước."
  exit 1
fi

# Tạo docker-compose.yml nếu chưa có
cat <<EOF > docker-compose.yml
version: "3"
services:
  selenium-hub:
    image: selenium/hub:4.21.0
    container_name: selenium-hub
    ports:
      - "4444:4444"

  usera-node:
    image: selenium/node-chrome:4.21.0
    shm_size: 2gb
    depends_on:
      - selenium-hub
    environment:
      - SE_EVENT_BUS_HOST=selenium-hub
      - SE_EVENT_BUS_PUBLISH_PORT=4442
      - SE_EVENT_BUS_SUBSCRIBE_PORT=4443

  userb-node:
    image: selenium/node-chrome:4.21.0
    shm_size: 2gb
    depends_on:
      - selenium-hub
    environment:
      - SE_EVENT_BUS_HOST=selenium-hub
      - SE_EVENT_BUS_PUBLISH_PORT=4442
      - SE_EVENT_BUS_SUBSCRIBE_PORT=4443

  runner-node:
    image: selenium/node-chrome:4.21.0
    shm_size: 2gb
    depends_on:
      - selenium-hub
    environment:
      - SE_EVENT_BUS_HOST=selenium-hub
      - SE_EVENT_BUS_PUBLISH_PORT=4442
      - SE_EVENT_BUS_SUBSCRIBE_PORT=4443
EOF

echo "🚀 Đang khởi động Selenium Grid với 3 Node..."
docker-compose up -d
sleep 5
echo "✅ Grid chạy tại http://localhost:4444/ui"