# gRPC example
This section is a very simple grpc example which simulates the JSON payload being transferred between server and client

## How to install
Run the pip install on the requirements.txt to include all the necessary components
```
pip install -r requirements.txt
```

## How to run
Simply run follow commands to compile the proto code to become python library 

```
python -m grpc_tools.protoc -I . --python_out=. --grpc_python_out=. ecommerce.proto
```

Next run the server to await for client request
```
python server.py
```
Run client to trigger product registeration to server and retrieve the data
```
python client.py
```
You should see the output result at consumer.py
```
Created Order: id: 123
items {
  id: 1
  name: "Product A"
  price: 10.99
}
items {
  id: 2
  name: "Product B"
  price: 5.99
}
customer_name: "Albert"
address: "123 Street 1"

Retrieved Order: id: 123
items {
  id: 1
  name: "Product A"
  price: 10.99
}
items {
  id: 2
  name: "Product B"
  price: 5.99
}
customer_name: "Albert"
address: "123 Street 1"
```