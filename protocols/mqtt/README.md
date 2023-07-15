# MQTT example
This section is a very simple mqtt example which simulates the payload being transferred between publisher and subscriber in specific topic

MQTT is a popular choice for IoT applications due to its lightweight nature, low network overhead, and support for low-power devices. It allows for efficient and reliable communication between IoT devices, sensors, and gateways, enabling real-time data exchange and control.

## How to install
Run the pip install on the requirements.txt to include all the necessary components
```
pip install -r requirements.txt
```

## How to run
Simply run follow commands to start the execution, first run the mqtt broker using docker compose

```
docker compose up
```
Run mqtt_subscriber to receieve payload
```
python mqtt_subscriber.py
```

Next run the mqtt_publisher to generate payload
```
python mqtt_publisher.py
```

You should see the output result at consumer.py
```
Received message: {'sensorId': 'sensor-001', 'temperature': 25.6, 'timestamp': 1628587200}
```