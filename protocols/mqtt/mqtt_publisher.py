import paho.mqtt.client as mqtt
import json

# Create an MQTT client
client = mqtt.Client()

# Connect to the MQTT broker
client.connect("localhost", 1883)

# Define the MQTT topic
topic = "sensors/temperature"

# Create a JSON payload
payload = {
    "sensorId": "sensor-001",
    "temperature": 25.6,
    "timestamp": 1628587200
}

# Convert the payload to JSON format
message = json.dumps(payload)

# Publish the message to the topic
client.publish(topic, message.encode())

# Disconnect from the broker
client.disconnect()
