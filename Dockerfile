# Sử dụng image Nginx phiên bản Alpine (nhẹ và tối ưu)
FROM alpine:latest
# Sao chép toàn bộ tệp và thư mục trong dự án CICD
# vào thư mục gốc mà Nginx dùng để phục vụ nội dung web.
COPY . /usr/share/nginx/html
RUN apk update && apk upgrade libexpat libxml2
RUN apk update && apk upgrade libxslt xz-libs
