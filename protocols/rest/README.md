# REST example
This section is a very simple mqtt example which simulates the payload being transferred between publisher and subscriber in specific topic

REST is widely used for building web APIs that allow different software systems to communicate with each other over the internet. RESTful APIs provide a standardized way to access and manipulate resources using HTTP methods like GET, POST, PUT, and DELETE. This makes it easier for different clients (web browsers, mobile apps, etc.) to interact with the API.

## How to install
Run the pip install on the requirements.txt to include all the necessary components
```
pip install -r requirements.txt
```

## How to run
Run the server up using server.py

```
python server.py
```
Run all the REST queries using python test
```
python -m pytest test.py
```

You should see the output result after the run, this means the unit test has been completed
```
collected 3 items                                                        

test.py ...                                                        [100%]
```