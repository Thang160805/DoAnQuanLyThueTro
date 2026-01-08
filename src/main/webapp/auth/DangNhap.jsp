<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Google Fonts: Poppins (Hiện đại, tròn trịa giống Airbnb) -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">
<!-- Bootstrap 5 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome Icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/DangNhap.css">
<style>
body {
            font-family: "Open Sans", sans-serif;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f0f2f5;
            /* Ảnh nền phòng trọ/urban style */
            background-image: url('https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?auto=format&fit=crop&w=2500&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            position: relative;
            overflow: hidden;
        }
.error-message {
	background-color: #f8d7da;
	color: #721c24; 
	border: 1px solid #f5c6cb;
	border-radius: 8px;
	padding: 0.85rem 1rem;
	font-size: 0.9rem;
	font-weight: 500;
	margin-bottom: 15px;
	display: flex;
	align-items: center;
	gap: 0.6rem;
	width: 100%; 
	min-height: 45px;
}

.error-message i {
	color: #dc3545;
	font-size: 1.1rem;
	line-height: 1;
}


.error-message .error-text {
	flex-grow: 1; 
}
</style>
</head>
<body>
	<!-- Back Button -->
	<div class="top-nav">
		<a href="${pageContext.request.contextPath}/index.jsp"
			class="btn-back"> <i class="fa-solid fa-arrow-left"></i> Quay lại
			trang giới thiệu
		</a>
	</div>

	<div class="auth-card">

		<!-- --- VIEW 1: LOGIN --- -->
		<div id="login-view" class="auth-view active">
			<div class="brand-area">
				<a href="#" class="logo"><i class="fa-solid fa-house-chimney"></i>
					FindRoom</a>
				<p class="slogan">Đăng nhập để bắt đầu tìm phòng trọ thông minh</p>
			</div>
			

			<form id="loginForm">
				<!-- Email/Phone -->
				<div class="form-group">
					<div class="input-wrapper">
						<i class="fa-regular fa-user input-icon"></i> <input
							type="text" class="form-control" name="username"
							placeholder="Tên đăng nhập">
					</div>

				</div>

				<!-- Password -->
				<div class="form-group">
					<div class="input-wrapper">
						<i class="fa-solid fa-lock input-icon"></i> <input type="password"
							class="form-control" name="password" placeholder="Mật khẩu"
							> <i class="fa-regular fa-eye toggle-password" onclick="togglePassword(this)"></i>
					</div>

				</div>

				<!-- Options -->
				<div class="form-options d-flex justify-content-end">
					<a href="${pageContext.request.contextPath}/auth/QuenMatKhau.jsp" class="forgot-link">Quên mật khẩu?</a>
				</div>

				<!-- Button -->
				<button type="submit" class="btn-primary" id="btnLogin">
					Đăng Nhập</button>
			</form>

			<!-- Social -->
			<div class="divider">
				<span>Hoặc tiếp tục với</span>
			</div>
			<div class="social-row">
				<button class="btn-social">
					<img
						src="https://img.icons8.com/?size=100&id=17949&format=png&color=000000"
						width="20"> Google
				</button>
				<button class="btn-social">
					<img
						src="https://upload.wikimedia.org/wikipedia/commons/5/51/Facebook_f_logo_%282019%29.svg"
						width="20"> Facebook
				</button>
			</div>

			<!-- Footer Link -->
			<div class="auth-footer">
				Chưa có tài khoản? <a
					href="${pageContext.request.contextPath}/auth/DangKy.jsp">Đăng
					ký ngay</a>
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
<script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

	<script>
		// Ẩn/Hiện mật khẩu
		function togglePassword(icon) {
			const input = icon.previousElementSibling;
			if (input.type === "password") {
				input.type = "text";
				icon.classList.replace("fa-eye", "fa-eye-slash");
			} else {
				input.type = "password";
				icon.classList.replace("fa-eye-slash", "fa-eye");
			}
		}
		
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
            $("#loginForm").on("submit", function (e) {
                e.preventDefault(); // Ngăn reload trang

                $.ajax({
                    url: "/DoAnQLThueTro/DangNhapServlet",
                    type: "post",
                    dataType: "json",
                    data: $(this).serialize(),  // Tự động gom tất cả name=""
                    success: function (response) {
                        if (response.status === "success") {
                            showToast("Đăng nhập thành công!");

                            // Chuyển trang theo URL controller trả về
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