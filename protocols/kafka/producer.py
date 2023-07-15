from kafka import KafkaProducer
from datetime import datetime
import json

# Kafka broker address
bootstrap_servers = 'localhost:9092'

# Create Kafka producer
producer = KafkaProducer(bootstrap_servers=bootstrap_servers)

# Kafka topic to produce messages to
topic = 'ai.detection'
timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

msg_json = {
  "message": {
    "topic": "my_topic",
    "payload": {
      "messageId": "abc123",
      "timestamp": "2023-07-15T12:34:56Z",
      "metadata": {
        "source": "camera_1",
        "confidence": 0.85
      },
      "data": {
        "object": "person",
        "boundingBox": {
          "x": 100,
          "y": 200,
          "width": 50,
          "height": 100
        }
      }
    }
  }
}

json_str = json.dumps(msg_json)

# Produce a message
producer.send(topic, json_str.encode())

# Close the producer
producer.close()
