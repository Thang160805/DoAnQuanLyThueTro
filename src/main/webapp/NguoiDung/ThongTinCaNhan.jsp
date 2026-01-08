<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.bean.TaiKhoan"%>
<%@ page import="utils.DateHelper"%>
<%@ page import="model.bean.ThongBao"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thông tin cá nhân</title>
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
<!-- Toastify CSS (Thông báo đẹp) -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/footer.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/ThongTinCaNhan.css">
	<style>
	body {
	font-family: "Open Sans", sans-serif;
	background-color: #f5f5f5;
	color: #222222;
	line-height: 1.6;
}
	</style>
</head>
<body>
	<%
	// Ngăn cache để không thể back sau khi logout
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);

	if (session.getAttribute("user") == null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	%>
	<%
	TaiKhoan tk = (TaiKhoan) request.getAttribute("ThongTinCaNhan");
	int countTB = (int) request.getAttribute("countTB");
	%>
	<header>
		<a class="navbar-brand" href="#"> <i
			class="fa-solid fa-house-chimney"></i> FindRoom
		</a>

		<nav>
			<ul class="nav-menu">
				<li class="nav-item"><a
					href="${pageContext.request.contextPath}/ProcessHomeUser">Trang
						chủ</a></li>
				<li class="nav-item"><a
					href="${pageContext.request.contextPath}/TimPhong">Tìm phòng</a></li>
				<li class="nav-item"><a href="${pageContext.request.contextPath}/PhongDaThue">Phòng đã thuê</a></li>
				<li class="nav-item"><a href="${pageContext.request.contextPath}/LichThanhToan">Lịch thanh toán</a></li>
				<li class="nav-item"><a href="${pageContext.request.contextPath}/HopDong">Hợp đồng</a></li>
			</ul>
		</nav>

		<div class="header-right">
			<div class="dropdown" onclick="toggleDropdown('notif-drop')">
				<div class="notification-icon">
					<i class="fa-regular fa-bell"></i>
					<%
					if (countTB > 0) {
					%>
					<span class="badge"><%=countTB%></span>
					<%
					}
					%>
				</div>
				<% ArrayList<ThongBao> list = (ArrayList<ThongBao>) request.getAttribute("listTB"); %>
				<div class="dropdown-content" id="notif-drop">
				<% for(ThongBao tb : list){
					%>
					<a href="${pageContext.request.contextPath}/ChiTietThongBao?id=<%= tb.getId() %>" class="dropdown-item"><%= tb.getTitle() %></a>
						<%} %> 
					<div class="dropdown-divider"></div>
					<a href="${pageContext.request.contextPath}/TatCaThongBao"
						class="dropdown-item" style="text-align: center; color: #1E90FF;">Xem
						tất cả</a>
				</div>
			</div>

			<div class="dropdown" onclick="toggleDropdown('user-drop')">
				<div class="user-profile">
					<img
						src="<%=(tk != null && tk.getAvatar() != null) ? tk.getAvatar() : ""%>"
						alt="User" class="avatar"> <i class="fa-solid fa-angle-down"
						style="font-size: 0.8rem; color: #666;"></i>
				</div>
				<div class="dropdown-content" id="user-drop">
					<a href="${pageContext.request.contextPath}/ThongTinCaNhan"
						class="dropdown-item"><i class="fa-regular fa-user"
						style="width: 20px"></i> Thông tin cá nhân</a> <a
						href="${pageContext.request.contextPath}/CaiDat"
						class="dropdown-item"><i class="fa-solid fa-gear"
						style="width: 20px"></i> Cài đặt</a>
					<div class="dropdown-divider"></div>
					<a href="${pageContext.request.contextPath}/Logout"
						class="dropdown-item" style="color: #e74c3c;"><i
						class="fa-solid fa-right-from-bracket" style="width: 20px"></i>
						Đăng xuất</a>
				</div>
			</div>
		</div>
	</header>
	<div class="container">

		<!-- 1. HEADER HỒ SƠ -->
		<div class="profile-hero">
			<img
				src="<%=(tk != null && tk.getAvatar() != null) ? tk.getAvatar() : ""%>"
				alt="Avatar" class="hero-avatar">
			<div class="hero-text">
				<h1><%=tk.getHoTen()%>
					<span class="verified-badge" title="Đã xác minh"><i
						class="fa-solid fa-check"></i></span>
				</h1>
				<div class="hero-meta">
					<span><i class="fa-regular fa-envelope"></i> <%=(tk != null && tk.getEmail() != null) ? tk.getEmail() : ""%></span>
					<span><i class="fa-solid fa-phone"></i> <%=(tk != null && tk.getSDT() != null) ? tk.getSDT() : ""%></span>
				</div>
			</div>
		</div>

		<!-- MAIN LAYOUT -->
		<div class="layout-grid">

			<!-- CỘT TRÁI: THÔNG TIN & CÀI ĐẶT -->
			<div class="left-col">
				<!-- 2. THÔNG TIN CÁ NHÂN -->
				<div class="card">
					<div class="card-header">
						<div class="card-title">
							<i class="fa-regular fa-id-card" style="color: #2E90FF;"></i>
							Thông tin cá nhân
						</div>
					</div>

					<div class="info-list">
						<div class="info-item">
							<div class="info-icon">
								<i class="fa-regular fa-user"></i>
							</div>
							<div class="info-content">
								<label>Họ và tên</label>
								<p><%=(tk != null && tk.getHoTen() != null) ? tk.getHoTen() : ""%></p>
							</div>
						</div>

						<div class="info-item">
							<div class="info-icon">
								<i class="fa-regular fa-id-card"></i>
							</div>
							<div class="info-content">
								<label>CCCD</label>
								<p><%=(tk != null && tk.getCCCD() != null) ? tk.getCCCD() : ""%></p>
							</div>
						</div>

						<div class="info-item">
							<div class="info-icon">
								<i class="fa-solid fa-venus-mars"></i>
							</div>
							<div class="info-content">
								<label>Giới tính</label>
								<p><%=(tk != null && tk.getGioiTinh() != -1) ? (tk.getGioiTinh() == 1 ? "Nam" : "Nữ") : ""%></p>
							</div>
						</div>

						<div class="info-item">
							<div class="info-icon">
								<i class="fa-regular fa-calendar"></i>
							</div>
							<div class="info-content">
								<label>Ngày sinh</label>
								<p><%=(tk != null && tk.getNgaySinh() != null) ? DateHelper.formatVN(tk.getNgaySinh()) : ""%></p>
							</div>
						</div>

						<div class="info-item">
							<div class="info-icon">
								<i class="fa-solid fa-phone"></i>
							</div>
							<div class="info-content">
								<label>Số điện thoại</label>
								<p><%=(tk != null && tk.getSDT() != null) ? tk.getSDT() : ""%></p>
							</div>
						</div>

						<div class="info-item">
							<div class="info-icon">
								<i class="fa-solid fa-location-dot"></i>
							</div>
							<div class="info-content">
								<label>Địa chỉ</label>
								<p><%=(tk != null && tk.getDiaChi() != null) ? tk.getDiaChi() : ""%></p>
							</div>
						</div>


					</div>
				</div>

				<!-- 5. SETTINGS REDIRECT (Card chuyển hướng) -->
				<a href="${pageContext.request.contextPath}/CaiDat"
					class="settings-card">
					<div class="settings-info">
						<div class="settings-icon">
							<i class="fa-solid fa-gear"></i>
						</div>
						<div>
							<div style="font-weight: 700; font-size: 1.1rem; color: #2D3748;">Cài
								đặt tài khoản</div>
							<div style="font-size: 0.9rem; color: #A0AEC0;">Mật khẩu,
								bảo mật, thông báo</div>
						</div>
					</div> <i class="fa-solid fa-chevron-right" style="color: #A0AEC0;"></i>
				</a>
			</div>

			<!-- CỘT PHẢI: HOẠT ĐỘNG -->
			<div class="right-col">
				<!-- 3. HOẠT ĐỘNG NGƯỜI DÙNG (OVERVIEW) -->
				<div class="overview-grid">
					<div class="stat-card">
						<div class="stat-icon"
							style="background: #E6F2FF; color: #2E90FF;">
							<i class="fa-solid fa-eye"></i>
						</div>
						<div class="stat-value">28</div>
						<div class="stat-label">Phòng đã xem</div>
					</div>
					<div class="stat-card">
						<div class="stat-icon"
							style="background: #F6FFED; color: #52C41A;">
							<i class="fa-solid fa-key"></i>
						</div>
						<div class="stat-value">2</div>
						<div class="stat-label">Đã thuê</div>
					</div>
				</div>

				<!-- 4. HOẠT ĐỘNG GẦN ĐÂY (LIST) -->
				<div class="card">
					<div class="card-header">
						<div class="card-title">
							<i class="fa-solid fa-clock-rotate-left" style="color: #2E90FF;"></i>
							Hoạt động gần đây
						</div>
						<button class="btn btn-ghost">
							Xem tất cả <i class="fa-solid fa-arrow-right"
								style="margin-left: 5px;"></i>
						</button>
					</div>

					<div class="activity-list">
						<!-- Item 1 -->
						<div class="activity-item">
							<img
								src="https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=200"
								alt="Room" class="activity-thumb">
							<div class="activity-details">
								<div class="activity-name">Studio Full nội thất - Cầu Giấy</div>
								<div class="activity-price">4.500.000đ/tháng</div>
								<div class="activity-address">
									<i class="fa-solid fa-location-dot"></i> 123 Xuân Thủy, Cầu
									Giấy
								</div>
							</div>
							<div class="activity-arrow">
								<i class="fa-solid fa-arrow-right"></i>
							</div>
						</div>

						<!-- Item 2 -->
						<div class="activity-item">
							<img
								src="https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=200"
								alt="Room" class="activity-thumb">
							<div class="activity-details">
								<div class="activity-name">Phòng trọ gác xép hiện đại</div>
								<div class="activity-price">3.200.000đ/tháng</div>
								<div class="activity-address">
									<i class="fa-solid fa-location-dot"></i> Ngõ 68 Hồ Tùng Mậu
								</div>
							</div>
							<div class="activity-arrow">
								<i class="fa-solid fa-arrow-right"></i>
							</div>
						</div>

						<!-- Item 3 -->
						<div class="activity-item">
							<img
								src="https://images.unsplash.com/photo-1505693314120-0d443867891c?w=200"
								alt="Room" class="activity-thumb">
							<div class="activity-details">
								<div class="activity-name">Chung cư mini Yên Hòa (2PN)</div>
								<div class="activity-price">5.000.000đ/tháng</div>
								<div class="activity-address">
									<i class="fa-solid fa-location-dot"></i> Phố Yên Hòa, Cầu Giấy
								</div>
							</div>
							<div class="activity-arrow">
								<i class="fa-solid fa-arrow-right"></i>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="../includes/footer.jsp"%>



	<script>
        function toggleDropdown(id) {
            // Đóng các dropdown khác
            const allDropdowns = document.querySelectorAll('.dropdown-content');
            allDropdowns.forEach(d => {
                if(d.id !== id) d.parentElement.classList.remove('active');
            });

            // Mở/Đóng cái hiện tại
            const element = document.getElementById(id);
            element.parentElement.classList.toggle('active');
        }

        // Click ra ngoài thì đóng
        window.onclick = function(event) {
            if (!event.target.closest('.dropdown')) {
                const dropdowns = document.querySelectorAll(".dropdown");
                dropdowns.forEach(openDropdown => {
                    openDropdown.classList.remove('active');
                });
            }
        }
        
        const modal = document.getElementById('updateModal');
        const body = document.body;

        function openModal() {
            modal.classList.add('active');
            body.style.overflow = 'hidden'; // Prevent background scrolling
            
            // Sync current values to inputs (in case text changed)
            document.getElementById('inputName').value = document.getElementById('displayFullname').innerText;
            // ... (sync other fields if needed, simplified here)
        }

        function closeModal() {
            modal.classList.remove('active');
            body.style.overflow = 'auto';
        }

        // Close on click outside
        modal.addEventListener('click', function(e) {
            if (e.target === modal) closeModal();
        });


    </script>
</body>
</html>