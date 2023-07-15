import zmq
import os

def run_client():
    context = zmq.Context()
    socket = context.socket(zmq.SUB)
    socket.connect("tcp://localhost:5557")
    socket.subscribe(b'')

    folder_path = "/home/tuitachi/python-sync/client2"  # Thư mục để lưu file từ server

    while True:
        [filename, contents] = socket.recv_multipart()
        filename = filename.decode()

        file_path = os.path.join(folder_path, filename)

        with open(file_path, 'wb') as file:
            file.write(contents)

        print(f"Client 2: File received and saved: {filename}")


if __name__ == '__main__':
    run_client()
