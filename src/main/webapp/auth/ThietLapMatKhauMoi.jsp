<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.bean.TaiKhoan"%>
<%@ page import="model.bo.TaiKhoanBO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thiết lập mật khẩu</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/ThietLapMatKhau.css">
<style>
body {
    font-family: "Open Sans", sans-serif;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: #f0f2f5;
    position: relative;
    overflow: hidden;
}
.user-avatar img {
	width: 52px;
	height: 52px;
	object-fit: cover;
	border-radius: 50%;
	display: block;
}
</style>
</head>
<body>
	<%
	String TenDangNhap = request.getParameter("TenDangNhap");
	TaiKhoanBO tkBO = new TaiKhoanBO();
	TaiKhoan tk = tkBO.getThongTinByTenDN(TenDangNhap);
	request.setAttribute("ThongTin", tk);
	%>
	<div class="bg-image"></div>
	<div class="bg-overlay"></div>

	<div class="reset-card">
		<h2>Đặt lại mật khẩu</h2>
		<p class="subtitle">Vui lòng tạo mật khẩu mới cho tài khoản.</p>
		<%
		TaiKhoan taikhoan = (TaiKhoan) request.getAttribute("ThongTin");
		String avatar = taikhoan.getAvatar();
		String avatarUrl;
		if (avatar.startsWith("http://") || avatar.startsWith("https://")) {
		    avatarUrl = avatar;
		} else {
		    avatarUrl = request.getContextPath() + "/" + avatar;
		}
		%>
		<div class="user-summary">
			<div class="user-avatar">
				<img src="<%= avatarUrl%>">
			</div>
			<div class="user-info">
				<h3><%=tk.getHoTen()%></h3>
				<p>
					<i class="fa-solid fa-shield-halved"></i>
					<%=tk.getEmail()%></p>
			</div>
		</div>

		<form id="newPassForm">
		<input type="hidden" name="TenDangNhap" value="<%= TenDangNhap%>">
			<div class="form-group">
				<label class="form-label">Mật khẩu mới</label> <input
					type="password" name="password" class="form-control"
					placeholder="Ít nhất 6 ký tự"> <i
					class="fa-regular fa-eye toggle-password"
					onclick="togglePass('password', this)"></i>
			</div>

			<div class="form-group">
				<label class="form-label">Xác nhận mật khẩu</label> <input
					type="password" name="confirmPassword" class="form-control"
					placeholder="Nhập lại mật khẩu trên"> <i
					class="fa-regular fa-eye toggle-password"
					onclick="togglePass('confirmPassword', this)"></i>
			</div>

			<button type="submit" class="btn-submit">Lưu mật khẩu mới</button>
		</form>
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
	function togglePass(inputId, icon) {
        const input = document.getElementById(inputId);
        if (input.type === "password") {
            input.type = "text";
            icon.classList.remove("fa-eye");
            icon.classList.add("fa-eye-slash");
        } else {
            input.type = "password";
            icon.classList.remove("fa-eye-slash");
            icon.classList.add("fa-eye");
        }
    }
	
	function showToast(message, type = "success") {
	    const toast = $("#toast");
	    let iconHTML = "";

	    if (type === "error") {
	        toast.css("background-color", "#dc2626");
	        iconHTML = `<i class="fa-solid fa-circle-xmark" style="color:#fecaca; margin-right:8px;"></i>`;
	    } else {
	        toast.css("background-color", "#2563eb");
	        iconHTML = `<i class="fa-solid fa-circle-check" style="color:#4ade80; margin-right:8px;"></i>`;
	    }

	    toast.html(iconHTML + message);

	    toast.css({ opacity: "1", transform: "translateY(0)" });

	    setTimeout(() => {
	        toast.css({ opacity: "0", transform: "translateY(20px)" });
	    }, 5000);
	}
    
    
    $(document).ready(function () {
        $("#newPassForm").on("submit", function (e) {
            e.preventDefault();

            $.ajax({
                url: "/DoAnQLThueTro/ThietLapMatKhau",
                type: "POST",
                dataType: "json",
                data: $(this).serialize(),

                success: function (response) {
                    if (response.status === "success") {
                    	showToast(response.message, "success");
                        setTimeout(() => {
                            window.location.href = "DangNhap.jsp";
                        }, 1000);

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