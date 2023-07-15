import grpc
import ecommerce_pb2
import ecommerce_pb2_grpc

def run():
    channel = grpc.insecure_channel('localhost:50051')
    stub = ecommerce_pb2_grpc.OrderServiceStub(channel)

    # Create Order
    order_request = ecommerce_pb2.CreateOrderRequest(
        items=[
            ecommerce_pb2.Product(id=1, name="Product A", price=10.99),
            ecommerce_pb2.Product(id=2, name="Product B", price=5.99)
        ],
        customer_name="Albert",
        address="123 Street 1"
    )
    created_order = stub.CreateOrder(order_request)
    print(f"Created Order: {created_order}")

    # Get Order
    order_id = created_order.id
    get_order_request = ecommerce_pb2.GetOrderRequest(id=order_id)
    retrieved_order = stub.GetOrder(get_order_request)
    print(f"Retrieved Order: {retrieved_order}")

if __name__ == '__main__':
    run()