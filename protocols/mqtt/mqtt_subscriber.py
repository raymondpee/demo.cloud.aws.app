import paho.mqtt.client as mqtt
import json

# Callback function to handle received messages
def on_message(client, userdata, message):
    # Decode the message payload from JSON format
    payload = json.loads(message.payload.decode())
    print("Received message:", payload)

# Create an MQTT client
client = mqtt.Client()

# Set the message callback
client.on_message = on_message

# Connect to the MQTT broker
client.connect("localhost", 1883)

# Subscribe to the MQTT topic
topic = "sensors/temperature"
client.subscribe(topic)

# Loop to continuously receive messages
client.loop_forever()
