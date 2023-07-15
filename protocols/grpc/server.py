import grpc
from concurrent import futures
import ecommerce_pb2
import ecommerce_pb2_grpc

class OrderServicer(ecommerce_pb2_grpc.OrderServiceServicer):
    def __init__(self):
        self.order_cache = {}   

    def CreateOrder(self, request, context):
        # Perform order creation logic here
        order_id = 123
        new_order = ecommerce_pb2.Order(
            id=order_id,
            items=request.items,
            customer_name=request.customer_name,
            address=request.address
        )
        self.order_cache[order_id] = new_order
        return new_order

    def GetOrder(self, request, context):
        if request.id in self.order_cache:
            cached_order = self.order_cache[request.id]
            return cached_order
        return ecommerce_pb2.Order()

def serve():
    server = grpc.server(futures.ThreadPoolExecutor())
    ecommerce_pb2_grpc.add_OrderServiceServicer_to_server(OrderServicer(), server)
    server.add_insecure_port('[::]:50051')
    server.start()
    server.wait_for_termination()

if __name__ == '__main__':
    serve()
