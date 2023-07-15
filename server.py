import zmq
import os

def run_server():
    context = zmq.Context()
    frontend = context.socket(zmq.PULL)
    frontend.bind("tcp://*:5556")

    backend = context.socket(zmq.PUB)
    backend.bind("tcp://*:5557")

    folder_path = "/home/tuitachi/python-sync/server"  # Thư mục để lưu file từ client1

    while True:
        [client, filename, contents] = frontend.recv_multipart()
        print(f"Server: Received file '{filename.decode()}' from {client.decode()}")

        # Lưu file vào thư mục server
        file_path = os.path.join(folder_path, filename.decode())
        with open(file_path, 'wb') as file:
            file.write(contents)
        print(f"Server: File '{filename.decode()}' saved to server folder")

        # Gửi file cho client2
        backend.send_multipart([filename, contents])
        print(f"Server: Published file '{filename.decode()}' to other clients")


if __name__ == '__main__':
    run_server()
