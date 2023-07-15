# Kafka example
This section is a very simple kafka example which simulates the JSON payload being transferred between producer and consumer in specific topic

## How to install
Run the pip install on the requirements.txt to include all the necessary components
```
pip install -r requirements.txt
```

## How to run
Simply run follow commands to start the execution, first run the kafka and zookeeper using docker compose

```
docker compose up
```

Next run the producer to generate payload
```
python producer.py
```
Run consumer to receieve payload
```
python consumer.py
```
You should see the output result at consumer.py
```
Received message: {"message": {"topic": "my_topic", "payload": {"messageId": "abc123", "timestamp": "2023-07-15T12:34:56Z", "metadata": {"source": "camera_1", "confidence": 0.85}, "data": {"object": "person", "boundingBox": {"x": 100, "y": 200, "width": 50, "height": 100}}}}}
```