# Chọn phiên bản Nginx Alpine cụ thể và mới nhất (Kiểm tra phiên bản ổn định mới nhất trên Docker Hub)
# Ví dụ dùng 1.27, bạn nên kiểm tra và thay bằng bản vá lỗi mới nhất của 1.27 hoặc phiên bản ổn định mới hơn
FROM nginx:1.27-alpine

# --- Tối ưu bảo mật ---

# 1. Cập nhật các gói hệ điều hành lên phiên bản mới nhất tại thời điểm build
# Chuyển sang user root để thực hiện lệnh apk
USER root
RUN apk update && apk upgrade --no-cache

# 2. Sao chép *chỉ* các tệp ứng dụng cần thiết
# Quay lại sử dụng đường dẫn ./CICD/ vì code web nằm trong thư mục đó.
# Đảm bảo Dockerfile này nằm ở thư mục gốc repo, cùng cấp với thư mục CICD.
# Thêm --chown để user nginx (sẽ dùng ở dưới) có quyền đọc file.
COPY --chown=nginx:nginx . /usr/share/nginx/html/

# 3. (Tùy chọn) Nếu bạn có file cấu hình Nginx riêng, hãy sao chép nó vào
# Ví dụ: COPY --chown=nginx:nginx custom-nginx.conf /etc/nginx/conf.d/default.conf

# 4. Đảm bảo thư mục Nginx cần ghi (logs, cache, pid) có quyền phù hợp cho user nginx
# Các thư mục này thường được tạo sẵn và cấp quyền trong ảnh gốc, nhưng kiểm tra lại không thừa
RUN touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid && \
    chown -R nginx:nginx /var/cache/nginx

# 5. Chuyển sang chạy Nginx với user không phải root (user 'nginx' có sẵn trong ảnh gốc)
USER nginx

# --- Kết thúc tối ưu bảo mật ---

# Ghi chú: Ảnh gốc nginx:alpine đã EXPOSE 80 và có CMD phù hợp để chạy Nginx.
# Bạn không cần thêm chúng trừ khi muốn ghi đè.
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]

