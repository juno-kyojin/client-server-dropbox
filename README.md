# Client-Server-Dropbox
Đây là dự án mô phỏng chức năng cơ bản của Dropbox, bao gồm client và server để truyền tải và lưu trữ file bằng cách dùng rsync và inotify.

Tư tưởng bài toán
![Biểu đồ không có tiêu đề](https://github.com/juno-kyojin/client-server-dropbox/assets/136924962/01f0bae0-9dcc-400c-b987-b44f92f117f2)

## **Hướng dẫn cài đặt và hoạt động** <br>
### **Cài đặt** <br>
Cài đăt các thư viện cần thiết bằng lệnh (ubuntu20.04) trên terminal:
```terminal
sudo apt install inotify-tools #inotify-tools: cung cấp lệnh inotifywait để theo dõi các thay đổi của file. 

sudo apt install rsync #rsync: công cụ đồng bộ hóa file giữa các máy. 
```
### **Chạy code** <br>
Đảm bảo rằng các thư mục client1, client2, server và tmp đều đã dược tạo trước khi chạy script. 
Trước khi chạy script hãy cấp quyên cho nó để nó có thể hoạt động được 
```terminal
chmod +x server_script.sh
```
Mở terminal lên và thực hiện lệnh sau: 
```terminal
./server_script.sh # hoặc sudo ./server_script.sh nếu máy không đủ quyền để thực thi
```
