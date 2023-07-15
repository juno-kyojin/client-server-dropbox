import zmq
import os

def run_client():
    context = zmq.Context()
    socket = context.socket(zmq.PUSH)
    socket.connect("tcp://localhost:5556")

    folder_path = "/home/tuitachi/python-sync/client1"  # Thư mục chứa file của client1

    while True:
        filename = input("Enter the filename to send (or 'exit' to quit): ")

        if filename == "exit":
            break

        file_path = os.path.join(folder_path, filename)

        if not os.path.exists(file_path):
            print(f"File does not exist: {file_path}")
            continue

        with open(file_path, 'rb') as file:
            contents = file.read()
            socket.send_multipart([b'client1', filename.encode(), contents])

        print(f"Client 1: File sent: {filename}")


if __name__ == '__main__':
    run_client()
