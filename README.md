SFINANCE - Quản Lý Tài Chính Cá Nhân

Ứng dụng quản lý thu chi cá nhân được phát triển bằng **Flutter**, đáp ứng đầy đủ các tiêu chí kỹ thuật và nghiệp vụ của Bài tập lớn môn Lập trình Mobile. 
Ứng dụng hoạt động hoàn toàn offline, giúp người dùng theo dõi dòng tiền một cách trực quan, an toàn và tiện lợi.

---

## 🚀 Tính năng nổi bật 

* **📊 Dashboard Trực quan:** Tự động tính toán và hiển thị Tổng số dư, Tổng thu nhập và Tổng chi tiêu ngay trên màn hình chính.

* **📝 Quản lý Giao dịch (Full CRUD):**
    * **Create (Thêm):** Form nhập liệu với đầy đủ tính năng kiểm tra lỗi (Validate) số tiền, tên giao dịch và chọn ngày bằng DatePicker.
    * **Read (Xem):** Hiển thị danh sách giao dịch dưới dạng thẻ bo góc hiện đại, phân loại màu sắc Thu (Xanh) - Chi (Đỏ) rõ ràng. Có trạng thái Loading Indicator.
    * **Update (Sửa):** Hỗ trợ nạp lại (load) dữ liệu cũ lên form để người dùng dễ dàng chỉnh sửa.
    * **Delete (Xóa):** Cảnh báo an toàn bằng `AlertDialog` trước khi xóa vĩnh viễn dữ liệu.
    
* **🌙 Giao diện Tối/Sáng (Dark Mode):** Cho phép chuyển đổi giao diện và ghi nhớ tùy chọn của người dùng cho các lần mở app tiếp theo.

---

## 🛠 Công nghệ & Thư viện sử dụng

Dự án áp dụng kiến trúc **MVVM (Model - View - ViewModel)** thông qua việc phân chia thư mục rõ ràng: `models`, `screens`, `providers`, `data`.

* **Framework:** Flutter & Dart
* **Cơ sở dữ liệu cục bộ:** `sqflite` (Kết hợp `sqflite_common_ffi` để hỗ trợ chạy trên macOS/Windows).
* **Quản lý trạng thái (State Management):** `provider` (Tách biệt hoàn toàn logic ra khỏi giao diện).
* **Lưu trữ cấu hình:** `shared_preferences` (Lưu trạng thái giao diện Sáng/Tối).
* **Định dạng dữ liệu:** `intl` (Định dạng tiền tệ VNĐ và ngày tháng).

---

## 📂 Cấu trúc thư mục 
lib/
├── main.dart                  # Điểm bắt đầu của ứng dụng, thiết lập Provider
├── models/
│   └── transaction_model.dart # Định nghĩa cấu trúc dữ liệu Giao dịch
├── data/
│   └── database_helper.dart   # Khởi tạo SQLite và các hàm CRUD thao tác với DB
├── providers/
│   ├── transaction_provider.dart # Xử lý logic, tính toán tổng tiền và cập nhật UI
│   └── theme_provider.dart       # Quản lý trạng thái Dark/Light mode
└── screens/
    ├── home_screen.dart       # Màn hình chính (Dashboard & Danh sách)
    ├── add_edit_screen.dart   # Màn hình Thêm/Sửa giao dịch (Validate Form)
    ├── detail_screen.dart     # Màn hình chi tiết & Xử lý xóa
    └── settings_screen.dart   # Màn hình cài đặt giao diện