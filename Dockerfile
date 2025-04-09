# Sử dụng image Nginx chính thức dựa trên Alpine (đã có Nginx cài sẵn và cấu hình chạy)
FROM nginx:alpine
# Hoặc chỉ định phiên bản cụ thể hơn nếu muốn, ví dụ: nginx:1.27-alpine

# Ghi chú: Có thể bạn muốn xóa file cấu hình mặc định của Nginx nếu bạn có file cấu hình riêng.
# Ví dụ: RUN rm /etc/nginx/conf.d/default.conf

# Sao chép nội dung ứng dụng web tĩnh từ thư mục CICD trong context build
# vào thư mục phục vụ web mặc định của Nginx trong container.
# Quan trọng: Đảm bảo thư mục CICD chứa file index.html và các tài nguyên khác.
COPY ./CICD/ /usr/share/nginx/html/

# Ghi chú quan trọng:
# 1. Image nginx:alpine đã tự động EXPOSE cổng 80.
# 2. Image nginx:alpine đã có sẵn CMD để khởi động Nginx đúng cách.
#    Bạn KHÔNG cần thêm CMD ["nginx", "-g", "daemon off;"] trừ khi bạn muốn ghi đè cấu hình mặc định.

# Tạm thời bỏ qua các lệnh `apk upgrade` mà bạn đã thêm.
# Image nginx:alpine thường xuyên được cập nhật và có thể đã bao gồm các bản vá cần thiết.
# Nếu sau khi build lại với image này mà Trivy vẫn báo lỗi cho các thư viện đó,
# bạn mới cần xem xét thêm lại lệnh `RUN apk update && apk add --upgrade tên-gói` nếu thực sự cần thiết.
