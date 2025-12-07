<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<!-- Toastify CSS (Thông báo đẹp) -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/QuenMatKhau.css">
</head>
<body>
<div class="bg-image"></div>
    <div class="bg-overlay"></div>

    <div class="forgot-card">
        <div class="brand-icon">
            <i class="fa-solid fa-user-shield"></i> </div>
        
        <h2>Khôi phục mật khẩu</h2>
        <p class="subtitle" id="instruction-text">
            Nhập <b>Tên đăng nhập</b> của bạn. Chúng tôi sẽ gửi hướng dẫn đến email hoặc số điện thoại đã đăng ký.
        </p>

        <form id="reset-form">
            <div class="form-group">
                <input type="text" name="TenDangNhap" class="form-control" placeholder="Nhập tên đăng nhập của bạn">
                <i class="fa-regular fa-user input-icon"></i>
            </div>

            <button type="submit" class="btn-submit" id="submit-btn">
                Tìm tài khoản
            </button>
        </form>

        <a href="#" class="back-link">
            <i class="fa-solid fa-arrow-left"></i> Quay lại đăng nhập
        </a>
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
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
        $("#reset-form").on("submit", function (e) {
            e.preventDefault();

            $.ajax({
                url: "/DoAnQLThueTro/QuenMatKhau",
                type: "POST",
                dataType: "json",
                data: $(this).serialize(),

                success: function (response) {
                    if (response.status === "success") {
                        setTimeout(() => {
                            window.location.href = "ThietLapMatKhauMoi.jsp?TenDangNhap=" 
                                + encodeURIComponent(response.TenDangNhap);
                        }, 1500);

                    } else {
                        showToast(response.message, "error");
                    }
                },

                error: function () {
                    showToast("Lỗi hệ thống, vui lòng thử lại!", "error");
                }
            });
        });
    });
    </script>
</body>
</html>