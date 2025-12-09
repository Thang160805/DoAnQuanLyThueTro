<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.ArrayList"%>
<%@ page import="model.bean.TaiKhoan"%>
<%@ page import="model.bean.PhongTro"%>
<%@ page import="utils.CurrencyHelper"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Inter:wght@400;500;600&display=swap"
	rel="stylesheet">
<!-- Bootstrap 5 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome Icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/YCThueTro.css">
	<style>
	.navbar-brand {
	font-weight: 800;
	color: #1E90FF !important;
	font-size: 1.8rem;
	display: flex;
	align-items: center;
	gap: 10px;
}
	</style>
</head>
<body>
<% TaiKhoan tk = (TaiKhoan) request.getAttribute("ThongTin");
int ID_Phong = (int) request.getAttribute("ID_Phong");
PhongTro pt = (PhongTro) request.getAttribute("ThongTinPhong");
%>
<div class="container">
    <nav class="navbar">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/ProcessHomeUser"> <i
			class="fa-solid fa-house-chimney"></i> FindRoom
		</a>
        <a href="${pageContext.request.contextPath}/ChiTietPhong_1?ID_Phong=<%= ID_Phong %>" class="btn-back">
            <i class="fa-solid fa-arrow-left"></i> Quay lại
        </a>
    </nav>

    <header class="page-header">
        <h1>Gửi yêu cầu thuê</h1>
        <p>Hoàn tất thông tin bên dưới để gửi yêu cầu đến chủ nhà.</p>
    </header>

    <div class="layout-grid">
        
        <main>
            <div class="card-left">
                <div class="card-header">
                    <div class="card-title">Thông tin người thuê</div>
                    <div class="card-desc">Vui lòng điền chính xác để chủ nhà có thể liên hệ với bạn.</div>
                </div>

                <form id="rentalForm">
                <input type="hidden" name="ID_Phong" value="<%=( ID_Phong != -1) ? ID_Phong : ""%>">
                <input type="hidden" name="ID_TaiKhoan" value="<%=(tk != null && tk.getId() != -1) ? tk.getId() : ""%>">
                    <div class="form-grid">
                        <div class="form-group col-span-2">
                            <label>Họ và tên</label>
                            <div class="input-box">
                                <i class="fa-regular fa-user"></i>
                                <input type="text" class="form-control" placeholder="<%=(tk != null && tk.getHoTen() != null) ? tk.getHoTen() : ""%>" disabled>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Email</label>
                            <div class="input-box">
                                <i class="fa-regular fa-envelope"></i>
                                <input type="email" class="form-control" placeholder="<%=(tk != null && tk.getEmail() != null) ? tk.getEmail() : ""%>" disabled>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Số điện thoại</label>
                            <div class="input-box">
                                <i class="fa-solid fa-phone"></i>
                                <input type="tel" class="form-control" placeholder="<%=(tk != null && tk.getSDT() != null) ? tk.getSDT() : ""%>" disabled>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Ngày dọn vào dự kiến</label>
                            <div class="input-box">
                                <i class="fa-regular fa-calendar"></i>
                                <input name="NgayDonVao" type="date" class="form-control" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Thời hạn thuê</label>
                            <div class="input-box">
                                <i class="fa-regular fa-clock"></i>
                                <select name="ThoiHanThue" class="form-control" style="appearance: none;">
                                    <option value="1 tháng">1 tháng</option>
                                    <option value="3 tháng">3 tháng</option>
                                    <option value="6 tháng">6 tháng</option>
                                    <option value="12 tháng">1 năm</option>
                                </select>
                                <i class="fa-solid fa-chevron-down" style="left: auto; right: 14px;"></i>
                            </div>
                        </div>

                        <div class="form-group col-span-2">
                            <label>Lời nhắn cho chủ nhà</label>
                            <textarea name="LoiNhan" class="form-control" placeholder="Ví dụ: Tôi là sinh viên năm cuối, muốn thuê ở lâu dài..."></textarea>
                        </div>

                        <div class="form-group col-span-2">
                            <label>Bạn muốn được liên hệ qua?</label>
                            <div class="contact-grid">
                                <label class="contact-item">
                                    <input type="radio" name="contact" value="Gọi điện" checked>
                                    <div class="contact-label">
                                        <i class="fa-solid fa-phone-volume"></i>
                                        <span>Gọi điện</span>
                                    </div>
                                </label>
                                <label class="contact-item">
                                    <input type="radio" name="contact" value="Zalo/Mess">
                                    <div class="contact-label">
                                        <i class="fa-brands fa-facebook-messenger"></i>
                                        <span>Zalo / Mess</span>
                                    </div>
                                </label>
                                <label class="contact-item">
                                    <input type="radio" name="contact" value="Tin nhắn">
                                    <div class="contact-label">
                                        <i class="fa-regular fa-comment-dots"></i>
                                        <span>Tin nhắn</span>
                                    </div>
                                </label>
                                <label class="contact-item">
                                    <input type="radio" name="contact" value="Email">
                                    <div class="contact-label">
                                        <i class="fa-regular fa-envelope"></i>
                                        <span>Email</span>
                                    </div>
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="form-footer">
                        <a href="${pageContext.request.contextPath}/ChiTietPhong_1?ID_Phong=<%= ID_Phong %>" type="button" class="btn btn-ghost">Hủy bỏ</a>
                        <button type="submit" class="btn btn-primary">
                            <span>Gửi yêu cầu</span>
                            <i class="fa-regular fa-paper-plane"></i>
                        </button>
                    </div>
                </form>
            </div>
        </main>

        <aside class="sticky-sidebar">
            <div class="card room-preview">
                <div class="room-img-wrapper">
                    <img src="<%=(pt != null && pt.getAnhChinh() != null) ? pt.getAnhChinh() : ""%>" alt="Phòng trọ">
                    <div class="status-badge"><%=(pt != null && pt.getTrangThai() != null) ? pt.getTrangThai() : ""%></div>
                </div>

                <div class="room-content">
                    <h3 class="room-title"><%=(pt != null && pt.getTenPhong() != null) ? pt.getTenPhong() : ""%></h3>
                    <div class="room-address">
                        <i class="fa-solid fa-location-dot" style="margin-top:2px;"></i>
                        <span><%=(pt != null && pt.getDiaChi() != null) ? pt.getDiaChi() : ""%></span>
                    </div>

                    <div class="room-price">
                        <%=(pt != null && pt.getGiaThue() != -1) ? CurrencyHelper.format(pt.getGiaThue()) : ""%>đ <span>/tháng</span>
                    </div>

                    <div class="divider"></div>

                    <div class="owner-mini">
                        <div class="owner-avt">
                            <i class="fa-solid fa-user"></i>
                        </div>
                        <div class="owner-details">
                            <div><%=(pt != null && pt.getTenCT() != null) ? pt.getTenCT() : ""%></div>
                            <div>Chủ nhà • Phản hồi 100%</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div style="text-align: center; margin-top: 16px; font-size: 13px; color: #6b7280;">
                <i class="fa-solid fa-shield-halved"></i> Thông tin của bạn được bảo mật.
            </div>
        </aside>

    </div>
</div>
<div id="toast"
     style="
        position:fixed; 
        top:20px; 
        right:20px; 
        background:#1e293b; 
        color:white; 
        padding:12px 24px; 
        border-radius:50px; 
        font-weight:600; 
        font-size:14px; 
        box-shadow:0 10px 20px rgba(0,0,0,0.2); 
        opacity:0; 
        transition:0.3s; 
        transform:translateY(-20px); 
        pointer-events:none;
     ">
</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script>
function showToast(message, type = "success") {
    const toast = $("#toast");

    // Icon hiển thị theo loại
    let iconHTML = "";

    if (type === "error") {
        toast.css("background-color", "#dc2626"); // đỏ
        iconHTML = `<i class="fa-solid fa-circle-xmark" style="color:#fecaca; margin-right:8px;"></i>`;
    } else {
        toast.css("background-color", "#2563eb"); // xanh
        iconHTML = `<i class="fa-solid fa-circle-check" style="color:#4ade80; margin-right:8px;"></i>`;
    }

    // Set nội dung kèm icon
    toast.html(iconHTML + message);

    // hiện
    toast.css({ opacity: "1", transform: "translateY(0)" });

    // tự tắt sau 5 giây
    setTimeout(() => {
        toast.css({ opacity: "0", transform: "translateY(20px)" });
    }, 5000);
}

$(document).ready(function () {
    $("#rentalForm").on("submit", function (e) {
        e.preventDefault();

        $.ajax({
            url: "/DoAnQLThueTro/XuLyYeuCauThueTro",
            type: "POST",
            data: $(this).serialize(),
            dataType: "json",

            success: function (res) {

                // Delay 5 giây trước khi hiện thông báo
                setTimeout(function () {

                    if (res.status === "success") {
                        showToast("Bạn đã gửi yêu cầu thành công, vui lòng chờ duyệt!", "success");
                    } else {
                        showToast("Gửi yêu cầu thất bại! Vui lòng thử lại.", "error");
                    }

                }, 5000);

            },

            error: function () {

                setTimeout(function () {
                    showToast("Không thể kết nối đến server!", "error");
                }, 5000);

            }
        });

    });
});

</script>

</body>
</html>