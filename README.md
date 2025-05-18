# Script-Shader-Roblox-1.1
# Roblox Shader: Customizable Visual Enhancer

Một shader tuyệt đẹp cho Roblox được viết bằng Lua Script – giúp nâng tầm hình ảnh trong game của bạn với hiệu ứng **bloom**, **motion blur**, **sun rays**, **depth of field**, và **atmosphere**. Có thể **tùy chỉnh chất lượng** theo ý thích và đã hỗ trợ giao diện mobile tiện dụng.

---

## 🆕 Cập nhật mới nhất

### v1.2 - 2025-05-18

- Thêm **Giao diện người dùng (GUI)** cho mobile ở góc trên bên phải để chuyển đổi chất lượng shader
- Tối ưu hiệu ứng **motion blur** cho mobile — mượt hơn, đỡ mỏi mắt khi xoay camera nhanh
- **Nâng nhẹ vị trí mặt trời** để giảm độ chói, dịu mắt hơn khi nhìn trời
- **Tái cấu trúc mã nguồn**: dễ mở rộng thêm các tùy chỉnh trong tương lai

---

## ✨ Tính năng nổi bật:

- **3 chế độ chất lượng**: Low, Medium, High (F1–F3 hoặc nút GUI trên điện thoại)
- **Hiệu ứng Blur chuyển động thông minh**
- **Bloom ánh sáng và Sun Rays chân thực**
- **Depth of Field cinematic**
- **Atmosphere và Fog mờ ảo tạo chiều sâu**
- **Tự động chuyển hiệu ứng theo góc quay camera**
- **Giao diện gọn nhẹ cho mobile (góc trên bên phải)**

---

## ⚙️ Cách sử dụng

1. Dán đoạn loadstring sau vào Client và chạy

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/HyuiOWO/Script-Shader-Roblox-1.2/main/Shader.lua"))()
