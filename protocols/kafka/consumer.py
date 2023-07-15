from kafka import KafkaConsumer

# Kafka broker address
bootstrap_servers = 'localhost:9092'

# Create Kafka consumer
consumer = KafkaConsumer(bootstrap_servers=bootstrap_servers, auto_offset_reset='earliest')

# Kafka topic to consume messages from
topic = 'ai.detection'
consumer.subscribe([topic])

# Consume messages
for message in consumer:
    print(f'Received message: {message.value.decode()}')
