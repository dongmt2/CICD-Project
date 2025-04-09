# Sử dụng image Nginx chính thức dựa trên Alpine (đã có Nginx cài sẵn)
FROM nginx:alpine 
# FROM nginx:1.27-alpine # Hoặc chỉ định phiên bản cụ thể

# Xóa cấu hình Nginx mặc định (nếu cần - tùy cấu hình bạn muốn)
# RUN rm /etc/nginx/conf.d/default.conf 

# Sao chép nội dung ứng dụng web tĩnh (giả sử nằm trong thư mục CICD)
# vào thư mục phục vụ web mặc định của Nginx
COPY CICD/ /usr/share/nginx/html

# Ghi chú: Image nginx:alpine đã expose cổng 80 và có lệnh CMD để khởi động Nginx.
# Bạn không cần thêm EXPOSE 80 hay CMD ["nginx", "-g", "daemon off;"] trừ khi muốn ghi đè.

# Tạm thời bỏ qua các lệnh apk upgrade. 
# Bản nginx:alpine mới hơn có thể đã bao gồm các bản vá.
# Nếu sau khi build lại mà Trivy vẫn báo lỗi, hãy thêm lại lệnh cập nhật cần thiết:
# RUN apk update && apk add --upgrade libxslt xz-libs # Ví dụ
