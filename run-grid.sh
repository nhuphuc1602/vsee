#!/bin/bash

SELENIUM_JAR="selenium-server-4.33.0.jar"

echo "🟢 Starting Hub..."
nohup java -jar "$SELENIUM_JAR" hub --host localhost > hub.log 2>&1 &

sleep 5

echo "🔵 Starting Node A..."
nohup java -jar "$SELENIUM_JAR" node --config grid_config/master.json --port 5555 >  nodeA.log 2>&1 &

echo "🟡 Starting Node B..."
nohup java -jar "$SELENIUM_JAR" node --config grid_config/patient.json --port 6666 > nodeB.log 2>&1 &

echo "🟣 Starting Node C..."
nohup java -jar "$SELENIUM_JAR" node --config grid_config/provider.json --port 7777 > nodeC.log 2>&1 &

tail -f /dev/null
