<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Font Google: Poppins & Inter -->
    <link
        href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Inter:wght@400;500;600&display=swap"
        rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Toastify CSS (Thông báo đẹp) -->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
    <link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/DangKy.css">
</head>
<body>
<!-- Back Button -->
    <div class="top-nav">
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn-back">
            <i class="fa-solid fa-arrow-left"></i> Quay lại trang giới thiệu
        </a>
    </div>

    <div class="auth-card">
        <!-- --- VIEW 2: SIGNUP --- -->
        <div id="signup-view" class="auth-view">
            <div class="brand-area">
                <a href="#" class="logo"><i class="fa-solid fa-house-chimney"></i> FindRoom</a>
                <p class="slogan">Tạo tài khoản mới trong 30 giây</p>
            </div>

            <form id="signupForm">
                <div class="form-group">
                    <div class="input-wrapper">
                        <i class="fa-regular fa-user input-icon"></i>
                        <input type="text" name="username" class="form-control" placeholder="Tên đăng nhập">
                    </div>
                    
                </div>
                <div class="form-group">
                    <div class="input-wrapper">
                        <i class="fa-solid fa-lock input-icon"></i>
                        <input type="password" name="password" class="form-control" placeholder="Mật khẩu">
                    </div>
                  
                </div>
                <div class="form-group">
                    <div class="input-wrapper">
                        <i class="fa-solid fa-check-double input-icon"></i>
                        <input type="password" name="confirm-pass" class="form-control" placeholder="Nhập lại mật khẩu">
                    </div>
                    
                </div>
                <div class="form-group">
                    <div class="input-wrapper">
                        <i class="fa-solid fa-users-viewfinder input-icon"></i>
                        <select name="role" class="form-control form-select" style="padding-left: 45px;">
                            <option value="2">Tôi muốn tìm phòng</option>
                            <option value="1">Tôi muốn cho thuê</option>
                        </select>
                    </div>
                </div>

                <button type="submit" class="btn-primary" id="btnSignup">Đăng Ký Tài Khoản</button>
            </form>

            <div class="auth-footer">
                Đã có tài khoản? <a href="${pageContext.request.contextPath}/auth/DangNhap.jsp">Đăng nhập</a>
            </div>
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
			<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <!-- Toastify JS -->
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
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
        $("#signupForm").on("submit", function (e) {
            e.preventDefault();

            $.ajax({
                url: "/DoAnQLThueTro/DangKyServlet",
                type: "post",
                dataType: "json",
                data: $(this).serialize(),
                success: function (response) {
                    if (response.status === "success") {
                        showToast("Đăng ký thành công!");

                        setTimeout(() => {
                            window.location.href = response.redirect;
                        }, 800);

                    } else {
                        showToast(response.message, "error");
                    }
                },
                error: function () {
                    showToast("Có lỗi xảy ra!", "error");
                }
            });
        });
    });
    </script>

</body>
</html>