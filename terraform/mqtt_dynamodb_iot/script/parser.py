import argparse
import json
import paho.mqtt.client as mqtt
import asyncio
from AWSIoTPythonSDK.MQTTLib import AWSIoTMQTTClient
import threading
import time
import random

class MQTTParser:
    def __init__(self, id, broker_address, port, topics, iot_endpoint, iot_port, iot_root_ca_path, iot_key_path, iot_cert_path):
        self.id = id
        self.broker_address = broker_address
        self.port = port
        self.topics = topics
        self.aws_mqtt_client = AWSIoTMQTTClient("forwarder")
        self.iot_endpoint = iot_endpoint
        self.iot_port = iot_port
        self.iot_root_ca_path = iot_root_ca_path
        self.iot_key_path = iot_key_path
        self.iot_cert_path = iot_cert_path

    def __del__(self):
        self.aws_mqtt_client.disconnect()

    def start(self):
        self.aws_mqtt_client.configureEndpoint(self.iot_endpoint, self.iot_port)
        self.aws_mqtt_client.configureCredentials(self.iot_root_ca_path, self.iot_key_path, self.iot_cert_path)
        self.aws_mqtt_client.connect()
        print("Connected to AWS IoT Core")
        self.publish_mock_data()

    def publish_mock_data(self):
        while True:
            timestamp = int(time.time())

            # TELEMETRY
            telemetry_id = 1
            telemetry_payload = {
                "Timestamp" : timestamp,
                "Device": "telemetry",
                "DeviceID": telemetry_id,
                "Speed": round(random.uniform(20, 30), 2)
            }
            telemetry_payload_json = json.dumps(telemetry_payload)
            self.aws_mqtt_client.publish("car/" + str(self.id) + "/sensor", telemetry_payload_json, 1)
            print("Published telemetry message:", telemetry_payload_json)
            time.sleep(2)

            # CAMERA
            camera_id = 1
            timestamp = int(time.time())
            camera_payload = {
                "Timestamp" : timestamp,
                "Device": "camera",
                "DeviceID": camera_id,
                "Action": "No Action detected"
            }
            camera_payload_json = json.dumps(camera_payload)
            self.aws_mqtt_client.publish("car/" + str(self.id) + "/sensor", camera_payload_json, 1)
            print("Published camera message:", camera_payload_json)

            # Wait for 5 seconds before publishing the next message
            time.sleep(3)
 

# Example usage:
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Subscribe to MQTT topics and forward consolidated messages to AWS IoT Core")
    parser.add_argument("-e", "--iot_endpoint", required=True, help="AWS IoT Core endpoint")
    parser.add_argument("-p", "--iot_port", type=int, default=8883, help="AWS IoT Core port (default: 8883)")
    parser.add_argument("-r", "--iot_root_ca_path", required=True, help="Path to AWS IoT Core root CA certificate")
    parser.add_argument("-c", "--iot_cert_path", required=True, help="Path to device certificate")
    parser.add_argument("-k", "--iot_key_path", required=True, help="Path to device private key")
    parser.add_argument("-i", "--id", required=True, help="ID of the app")
    parser.add_argument("-j", "--parameters", required=True, help="Path to json parameters file")
    args = parser.parse_args()

    with open(args.parameters, "r") as file:
        parameters = json.load(file)

    broker_address = parameters["broker"]["address"]
    broker_port = parameters["broker"]["port"]
    topics = parameters["topics"]

    parser = MQTTParser(
        id = args.id,
        broker_address=broker_address,
        port=broker_port,
        topics=topics,
        iot_endpoint=args.iot_endpoint,
        iot_port=args.iot_port,
        iot_root_ca_path=args.iot_root_ca_path,
        iot_key_path=args.iot_key_path,
        iot_cert_path=args.iot_cert_path
    )
    parser.start()
